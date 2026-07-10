class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.613.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.613.0/ward-darwin-arm64"
      sha256 "1b3b6a997a50b48c2ef4183873127e4c8ef225ad22f2f20d21c5088fdd206632"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.613.0/ward-darwin-amd64"
      sha256 "a6757fe41e4649be78c6839b346ffdb377f63bc7924cd7b640abe04e73763f0f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.613.0/ward-linux-arm64"
      sha256 "81a15a3e77f98fdaf62f099721a6af101742026d5f3f7fa90568cb8d0f8110f9"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.613.0/ward-linux-amd64"
      sha256 "a3eab8666c51afcc195ef30fa01838f83ca0dc74bec1c5b55364a0258b44ebde"
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
