class Lilbee < Formula
  desc "Whole local AI stack in one binary: models, cited search, crawler"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.90b435"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-macos-arm64"
      sha256 "12a4d0e46965bba64098186b1d286cf83965646c347277fe88ae5dc656cd0c34"
    end

    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-macos-x86_64"
      sha256 "d280d401699243478f01b6ce8d6281211109ca62cee619f81b3a037c849ef654"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64"
      sha256 "88be5fb6ca398934b166c0ae51bf7c166cd28da7cf469fa3172c36c4f9c06b28"
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
