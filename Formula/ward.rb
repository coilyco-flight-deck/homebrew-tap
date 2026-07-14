class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.667.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.667.0/ward-darwin-arm64"
      sha256 "4ea06138403e6e8876d6e99f8d563dae6d75dc96d1216feb349f3e471e19338f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.667.0/ward-darwin-amd64"
      sha256 "0bcc3c9dfbdfd336b9f4ef6e6ad7e0d07fae813284d4db1c414800d7da425673"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.667.0/ward-linux-arm64"
      sha256 "6c03d20a5414d2e57486ca61284921646576f307e90c07bdf683cfd33cb5c18f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.667.0/ward-linux-amd64"
      sha256 "9cdc60287317a3ee6c1152d97683a3849753364792fd1b80c90c1df67e1b0ca5"
    end
  end

  def install
    asset =
      if OS.mac?
        Hardware::CPU.arm? ? "ward-darwin-arm64" : "ward-darwin-amd64"
      else
        Hardware::CPU.arm? ? "ward-linux-arm64" : "ward-linux-amd64"
      end

    chmod 0555, asset
    bin.install asset => "ward"

    bin.install_symlink "ward" => "warded"

  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
