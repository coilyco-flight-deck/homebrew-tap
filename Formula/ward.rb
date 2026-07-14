class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.689.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.689.0/ward-darwin-arm64"
      sha256 "0905add6092b05983bcb427f224558efa9702fb17cb9ac644dc8da6fb0d9c176"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.689.0/ward-darwin-amd64"
      sha256 "7ae33bbe4197a4ea0321f0d324975c884f676d05f0f285f6e6661a1a236e3863"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.689.0/ward-linux-arm64"
      sha256 "4bb9acba4bfa07a737bb8322a4115b2e463515257e865b1510f63bf06ccc1429"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.689.0/ward-linux-amd64"
      sha256 "b6138ca4ccc5fd32cf20e0220bdbedd28c010c45c7bb51cff10771bb1b30b3be"
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
