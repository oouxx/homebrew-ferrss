class Ferrss < Formula
  desc "AI-driven CLI tool that turns websites into command-line interfaces"
  homepage "https://github.com/oouxx/Ferrss"
  version "0.3.11"
  license "Apache-2.0"

  on_arm do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.11/ferrss-aarch64-apple-darwin.tar.gz"
    sha256 "f053456a7a3c61e499bfa609f110207eb6e2aa8ebbff50c100f5656b8cc98890"
  end

  on_intel do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.11/ferrss-x86_64-apple-darwin.tar.gz"
    sha256 "d9d03321875d16533eccf7558dcabfdc4ad61c6e96882bc2b12196f253b53f7f"
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
