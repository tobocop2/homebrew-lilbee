class LilbeeCuda < Formula
  desc "Whole local AI stack in one binary: models, cited search, crawler (CUDA build)"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.90b433"
  license "MIT"

  conflicts_with "tobocop2/lilbee/lilbee", because: "both install the lilbee binary"

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64-cu125"
      sha256 "f20a6347961c874b36fe74703660c02ca13434184a3a27db32d60f7fdf7a2003"
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
