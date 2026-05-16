class Lilbee < Formula
  desc "Local search engine and personal encyclopedia for your notes, code, and PDFs"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.66b476"
  license "Elastic-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-macos-arm64"
      sha256 "86cf0fbfcf5edb68f70129d70f2976a27e706ebaf2af01593a91a66190722edd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64"
      sha256 "c22ed4ed20545d04268bfd9e24a13759b294f105f836c0d898d9794d2454b6a7"
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
