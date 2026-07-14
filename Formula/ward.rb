class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.678.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.678.0/ward-darwin-arm64"
      sha256 "1aeb31fe5ddbadc558c6c6a819eb2a07bbd058e80b6e7a7868c16a6768e0da0b"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.678.0/ward-darwin-amd64"
      sha256 "4a7206acb1c5f54e96583630028574ef5adab24d6069e0b90ef911bb7735f8ba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.678.0/ward-linux-arm64"
      sha256 "c43216abd38b3fc92e3d3ac60c48be2195be86fae74b2e8a950eecf19d148d11"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.678.0/ward-linux-amd64"
      sha256 "d58169e1c31c522d5b11936c1cb7764d516a12b9e8cbd5117ce39c4712faa0a2"
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
