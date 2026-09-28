class LilbeeCompat < Formula
  desc "Run local AI models, search your files and code, and crawl the web (pre-Haswell CPU build)"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.90b448"
  license "MIT"

  conflicts_with "tobocop2/lilbee/lilbee", because: "both install the lilbee binary"
  conflicts_with "tobocop2/lilbee/lilbee-cuda", because: "both install the lilbee binary"

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-compat-linux-x86_64"
      sha256 "7ee56ff517bc1b37271ab92d418f97212690c3c3f77675dc7e37853967926f92"
    end
  end

  def install
    binary = Dir["lilbee-*"].first
    bin.install binary => "lilbee"
  end

  service do
    run [opt_bin/"lilbee", "serve", "--host", "127.0.0.1", "--port", "42697"]
    keep_alive true
    log_path var/"log/lilbee/serve.log"
    error_log_path var/"log/lilbee/serve.err.log"
  end

  def caveats
    <<~EOS
      lilbee-compat installs the same `lilbee` binary as the regular `lilbee` formula,
      held to an x86-64-v2 baseline so it runs on pre-Haswell CPUs (Sandy Bridge,
      Bulldozer). Only pick it if `lilbee` crashes with an illegal instruction. If you
      previously had `lilbee` installed, uninstall it first:

        brew uninstall lilbee
        brew install tobocop2/lilbee/lilbee-compat
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lilbee --version")
  end
end
