class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.601.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.601.0/ward-darwin-arm64"
      sha256 "305959d6a2ebcf120434c4909481f157b821391390e9ed7cee3d401ac382cd01"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.601.0/ward-darwin-amd64"
      sha256 "99e679373afbf109e7ac745cb6a05f0c0ec2e4d9d1415ee104067877686a77bd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.601.0/ward-linux-arm64"
      sha256 "5ae57fce58c84b45f8d5fbd91b19dfa166347b4b511bbe6361e4067998a3e327"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.601.0/ward-linux-amd64"
      sha256 "fa72c2ee950a5fbbcf8c47db5b4407fa2a20bdb94adf34fa648a3ef0022426e6"
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
