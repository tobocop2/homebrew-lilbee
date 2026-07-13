class LilbeeCompat < Formula
  desc "Run local AI models, search your files and code, and crawl the web (pre-Haswell CPU build)"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.90b420.dev719"
  license "Elastic-2.0"

  conflicts_with "tobocop2/lilbee/lilbee", because: "both install the lilbee binary"
  conflicts_with "tobocop2/lilbee/lilbee-cuda", because: "both install the lilbee binary"

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-compat-linux-x86_64"
      sha256 "801452661ed505eb82049f75a4551498bf5c5a66e1538f2dafa7cbe606669f5e"
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
