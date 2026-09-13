class Ferrss < Formula
  desc "AI-driven CLI tool that turns websites into command-line interfaces"
  homepage "https://github.com/oouxx/Ferrss"
  version "0.3.14"
  license "Apache-2.0"

  on_arm do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.14/ferrss-aarch64-apple-darwin.tar.gz"
    sha256 "840d72e1b33eba48ba33d8a95f78ff64104544b1c4b2218daa1c18c2f17eb535"
  end

  on_intel do
    url "https://github.com/oouxx/Ferrss/releases/download/v0.3.14/ferrss-x86_64-apple-darwin.tar.gz"
    sha256 "79d75aeb51d076e3c0e9fbc181d4050b76dfd782dd2f3a82bafe0fd6fed2997d"
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
