class Lilbee < Formula
  desc "Whole local AI stack in one binary: models, cited search, crawler"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.90b420.dev723"
  license "Elastic-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-macos-arm64"
      sha256 "24cf49c2d545381f5bef506231e9c27959c8212d5718d3fc1883ae336cf587d6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64"
      sha256 "a8d96f5bf96840a9e58888cfec2006a237a5ad822a1d2e6878708bfdb761e182"
    end
  end

  def install
    binary = Dir["lilbee-*"].first
    bin.install binary => "lilbee"

    # The binary is unsigned (Apple charges $99/yr for signing). Clear the
    # com.apple.quarantine xattr Homebrew applied during download so Gatekeeper
    # does not block first launch. Mirrors what the Obsidian plugin does at runtime.
    system "xattr", "-cr", bin/"lilbee" if OS.mac?
  end

  service do
    run [opt_bin/"lilbee", "serve", "--host", "127.0.0.1", "--port", "42697"]
    keep_alive true
    log_path var/"log/lilbee/serve.log"
    error_log_path var/"log/lilbee/serve.err.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lilbee --version")
  end
end
