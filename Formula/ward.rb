class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.858.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.858.0/ward-darwin-arm64"
      sha256 "9541fca0bfee365fd6ed284b6dce8f3c12c851ff474f28cd1cc3e9b5542e1916"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.858.0/ward-linux-arm64"
        sha256 "51e62589ff806b662b02ddd2bf9d66221295f1d4043312d690761fb790e93468"
      end
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.858.0/ward-darwin-amd64"
      sha256 "a2c8df93e09506ee41ee046be3c51518b6ec7cc79fb0ffe5a07c7916616649da"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.858.0/ward-linux-amd64"
        sha256 "a1783992a1d3fc8bbe4b6125f86ab858c79fdcfd7cc3e3e11f16c4e12c00305e"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.858.0/ward-linux-arm64"
      sha256 "51e62589ff806b662b02ddd2bf9d66221295f1d4043312d690761fb790e93468"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.858.0/ward-linux-amd64"
      sha256 "a1783992a1d3fc8bbe4b6125f86ab858c79fdcfd7cc3e3e11f16c4e12c00305e"
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

    if OS.mac?
      resource("ward-linux").stage do
        sidecar = Hardware::CPU.arm? ? "ward-linux-arm64" : "ward-linux-amd64"
        chmod 0555, sidecar
        libexec.install sidecar
      end
    end

    bin.install_symlink "ward" => "warded"

  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
