class Ferrss < Formula
  desc "AI-driven CLI tool that turns websites into command-line interfaces"
  homepage "https://github.com/oouxx/Ferrss"
  version "0.3.15"
  license "Apache-2.0"

  on_arm do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.15/ferrss-aarch64-apple-darwin.tar.gz"
    sha256 "7c6b4b807a2c10b62b7a1ded842dabd25b6ae617ee1e84cb00659ca19679e7c5"
  end

  on_intel do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.15/ferrss-x86_64-apple-darwin.tar.gz"
    sha256 "667ab423bd776202bfddf2b965f010f3be190fae9a6aaee6383eab107c4eaa94"
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
