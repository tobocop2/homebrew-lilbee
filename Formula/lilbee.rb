class Lilbee < Formula
  desc "Local search engine and personal encyclopedia for your notes, code, and PDFs"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.66b486"
  license "Elastic-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-macos-arm64"
      sha256 "87e2b07f172111b86fb1ab58444ba4245629d6ffa5e69b4cb550490d02f344ad"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64"
      sha256 "c71fef1f512cdda8eb8dde58ed07e4087a424afb863eff682b0abe8bb1606b30"
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
