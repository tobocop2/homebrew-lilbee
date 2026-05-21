class Lilbee < Formula
  desc "Local search engine and personal encyclopedia for your notes, code, and PDFs"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.66b480"
  license "Elastic-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-macos-arm64"
      sha256 "1d564022bfe914f2e3ebae58b7d813188a7dbe1ad278a5fa75d559dd60673ef8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64"
      sha256 "65dfa10172b44297e3aa30e6e188a0eb067c2d3396f000f037bf16ce2382f9d4"
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

  test do
    assert_match version.to_s, shell_output("#{bin}/lilbee --version")
  end
end
