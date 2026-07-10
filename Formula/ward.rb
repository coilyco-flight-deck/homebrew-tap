class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.595.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.595.0/ward-darwin-arm64"
      sha256 "d7566577101b777a7975accdc07f5ae319c651bc83808226f9cb059d834fc6be"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.595.0/ward-darwin-amd64"
      sha256 "80fe28cbda52b27c68765ddc8884e8fac2af1f48423af2d387bb14f7f0f4ffb5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.595.0/ward-linux-arm64"
      sha256 "292085b943e5ac9167849eebd4b04a090b1667bd62b320f275ba91c361b017e3"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.595.0/ward-linux-amd64"
      sha256 "d9d3b67ea3ed6ddbc10b6c9b345a464d8129d1b4d22a20d770710db18b235a5c"
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
