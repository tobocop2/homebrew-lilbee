class LilbeeCuda < Formula
  desc "Local search engine and personal encyclopedia for your notes, code, and PDFs (CUDA build)"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.66b476"
  license "Elastic-2.0"

  conflicts_with "tobocop2/lilbee/lilbee", because: "both install the lilbee binary"

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64-cu125"
      sha256 "71e84f731d25f0d9fba17d4852f301e59407a51fb0a20f07ba3649845760766d"
    end
  end

  def install
    binary = Dir["lilbee-*"].first
    bin.install binary => "lilbee"
  end

  def caveats
    <<~EOS
      lilbee-cuda installs the same `lilbee` binary as the regular `lilbee` formula,
      built against CUDA instead of Vulkan. If you previously had `lilbee` installed,
      uninstall it first:

        brew uninstall lilbee
        brew install tobocop2/lilbee/lilbee-cuda

      Requires an NVIDIA GPU and a matching CUDA driver (run `nvidia-smi` to check).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lilbee --version")
  end
end
