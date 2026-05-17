class LilbeeCuda < Formula
  desc "Local search engine and personal encyclopedia for your notes, code, and PDFs (CUDA build)"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.66b476"
  license "Elastic-2.0"

  conflicts_with "tobocop2/lilbee/lilbee", because: "both install the lilbee binary"

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64-cu125"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    binary = Dir["lilbee-*"].first
    bin.install binary => "lilbee"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lilbee --version")
  end
end
