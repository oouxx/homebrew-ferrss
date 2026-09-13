#!/usr/bin/env bash
# Generate Formula/ferrss.rb for a given release version.
# Usage: ./gen-formula.sh 0.3.11
set -euo pipefail

VERSION="${1:?usage: gen-formula.sh <version>}"
REPO="oouxx/Ferrss"
OUT="$(cd "$(dirname "$0")" && pwd)/Formula/ferrss.rb"

BASE="https://github.com/${REPO}/releases/download/v${VERSION}"

echo "Fetching SHA256SUMS.txt for v${VERSION}..."
SUMS="$(curl -fsSL "${BASE}/SHA256SUMS.txt")"

sum_for() {
  echo "$SUMS" | awk -v f="$1" '$2 == f { print $1 }'
}

ARM_SHA="$(sum_for "ferrss-aarch64-apple-darwin.tar.gz")"
INTEL_SHA="$(sum_for "ferrss-x86_64-apple-darwin.tar.gz")"

[ -n "$ARM_SHA" ] || { echo "missing arm64 checksum" >&2; exit 1; }
[ -n "$INTEL_SHA" ] || { echo "missing intel checksum" >&2; exit 1; }

mkdir -p "$(dirname "$OUT")"
cat > "$OUT" <<EOF
class Ferrss < Formula
  desc "AI-driven CLI tool that turns websites into command-line interfaces"
  homepage "https://github.com/${REPO}"
  version "${VERSION}"
  license "Apache-2.0"

  on_arm do
    url "${BASE}/ferrss-aarch64-apple-darwin.tar.gz"
    sha256 "${ARM_SHA}"
  end

  on_intel do
    url "${BASE}/ferrss-x86_64-apple-darwin.tar.gz"
    sha256 "${INTEL_SHA}"
  end

  def install
    bin.install "ferrss"
  end

  service do
    run [opt_bin/"ferrss", "serve", "--host", "0.0.0.0", "--port", "8080"]
    keep_alive true
    working_dir var
    log_path var/"log/ferrss-serve.log"
    error_log_path var/"log/ferrss-serve.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ferrss --version")
  end
end
EOF

echo "Wrote ${OUT}"
echo "  arm64 sha256: ${ARM_SHA}"
echo "  intel sha256: ${INTEL_SHA}"
