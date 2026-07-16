class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.775.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.775.0-tmp/ward-darwin-arm64",
          headers: ["Accept: application/octet-stream"]
      sha256 "f37c8335ec60838b591b588854f799b645879b3e8c1164d81bbb79d6262d0480"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.775.0-tmp/ward-darwin-amd64",
          headers: ["Accept: application/octet-stream"]
      sha256 "658b6d08afed5fe3d5147aa97f51692175edaafb0875480d9b986f6a9dbc9cc1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.775.0-tmp/ward-linux-arm64",
          headers: ["Accept: application/octet-stream"]
      sha256 "ec8c889e9f6e5887bea5b7acb77fd6a0e78edc68fd7b974390e01a2fdd0ad065"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.775.0-tmp/ward-linux-amd64",
          headers: ["Accept: application/octet-stream"]
      sha256 "d89b2bbb9506aa1a317b9efdd9845c02616b82c7d49bf0c885758acb2d03ab7c"
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
