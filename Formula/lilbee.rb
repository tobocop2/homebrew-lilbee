class Lilbee < Formula
  desc "Whole local AI stack in one binary: models, cited search, crawler"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.90b421"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-macos-arm64"
      sha256 "2788a0a2a9fc303282bbad8a9c6e360d1482fc30dafdab276e76e7e5d4457418"
    end

    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-macos-x86_64"
      sha256 "3f50a9e3236b643457eb3c1e5b6780c9e30b4c919af09444a81e484ea0b137e6"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64"
      sha256 "774d44d906dccc9b04bc1382484de31973a50c56f74bcc92d91bb150e22dc825"
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
