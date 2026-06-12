class LilbeeCuda < Formula
  desc "Local search engine and personal encyclopedia for your notes, code, and PDFs (CUDA build)"
  homepage "https://github.com/tobocop2/lilbee"
  version "0.6.66b494"
  license "Elastic-2.0"

  conflicts_with "tobocop2/lilbee/lilbee", because: "both install the lilbee binary"

  on_linux do
    on_intel do
      url "https://github.com/tobocop2/lilbee/releases/download/v#{version}/lilbee-linux-x86_64-cu125"
      sha256 "24736d61ae7bc8f96e31cf3c434b15ffa7880414f5f2519a51068e902d9cade0"
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
