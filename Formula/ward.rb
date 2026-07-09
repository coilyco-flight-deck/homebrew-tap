class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.531.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.531.0/ward-darwin-arm64"
      sha256 "d47a66b5d7e1d16d155d13873ae57810d377e47115463f7ed436b3d356c270ae"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.531.0/ward-darwin-amd64"
      sha256 "455a7c6585193e201ef7db6396a631538d21d1c9b5ca1e2f4a6246d85b83352a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.531.0/ward-linux-arm64"
      sha256 "509eae25bcbb7e44f2aca5aed5df97e3eb760a792ee920db4bb8705ea70b663f"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.531.0/ward-linux-amd64"
      sha256 "0fe5db026aae5ed7dd12b083e76484683fccf91dac03e46268471e3e0b0ea86b"
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
