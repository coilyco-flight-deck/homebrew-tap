class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.801.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/05189f0a-a8a6-4f05-aa9c-9edf8e805b93"
      sha256 "d5f9fd650cc03b44ec822cdbb0e1dd0ca6d9badc3318b686598af8788cf9f46b"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/e12096f8-fb0b-42ef-b100-b2e6cf7c4c4d"
        sha256 "73d1fe90789dd1053b0a22693dbe52697e0f238aeae6e0792e3241f0151c7069"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/df3cf1f8-186a-4215-8fd2-fd06ab5b03e2"
      sha256 "7ed1c5a13bb3e0c18f497237b27e9b8279ac4338bd384d1fc1c6104d8f204ddd"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/cb6c61a0-c715-445f-8981-45bcb47c8c85"
        sha256 "2c7b060f2a98fe6f577def1c7544437208e2f2b83a1056cd7fd53d89a3f3a5d8"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/e12096f8-fb0b-42ef-b100-b2e6cf7c4c4d"
      sha256 "73d1fe90789dd1053b0a22693dbe52697e0f238aeae6e0792e3241f0151c7069"
    else
      url "https://forgejo.coilysiren.me/attachments/cb6c61a0-c715-445f-8981-45bcb47c8c85"
      sha256 "2c7b060f2a98fe6f577def1c7544437208e2f2b83a1056cd7fd53d89a3f3a5d8"
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
