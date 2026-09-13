class Ferrss < Formula
  desc "AI-driven CLI tool that turns websites into command-line interfaces"
  homepage "https://github.com/oouxx/Ferrss"
  version "0.3.12"
  license "Apache-2.0"

  on_arm do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.12/ferrss-aarch64-apple-darwin.tar.gz"
    sha256 "285ef5239cdf90def6aaf1db2d0f5a4149cc0e1d154ac867a62766d9bf11b03d"
  end

  on_intel do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.12/ferrss-x86_64-apple-darwin.tar.gz"
    sha256 "cd052ea723cf7c3d4de251f3da5ae4651774e1b055704c6c04644f065f444ab4"
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
