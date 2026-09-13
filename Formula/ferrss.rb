class Ferrss < Formula
  desc "AI-driven CLI tool that turns websites into command-line interfaces"
  homepage "https://github.com/oouxx/Ferrss"
  version "0.3.13"
  license "Apache-2.0"

  on_arm do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.13/ferrss-aarch64-apple-darwin.tar.gz"
    sha256 "c8b6ead70b6ba18cdaaf8f3752a4e53991d7636bfef184fc104c66925c761017"
  end

  on_intel do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.13/ferrss-x86_64-apple-darwin.tar.gz"
    sha256 "d49790d9f594b2944f1c6afbee484c6abdc10ef0f5e61d9c4c439811a2332b3b"
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
