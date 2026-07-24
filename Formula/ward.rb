class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.799.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/d5f86626-d3cf-4378-a879-600e6f0ccb83"
      sha256 "5d8ab4bc56ca3476bbd1ca5939c27faa349c8b9472807cd3dd75a4adaf914596"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/5d1dad22-23e6-4abf-b521-ec8b0e6f4037"
        sha256 "6e2ec72a29119d4afc3ac70bad998eed6b14049d271482717f2d2aa5c62e751c"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/a99cbc52-6d8b-4107-8ef1-65c9b88f0466"
      sha256 "ebb63e66f5d169db9ddefb15e2295d85554fe7623c1c6151b1499989aaa64770"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/7b9e13ba-3c43-4ce5-b810-1997eb109c01"
        sha256 "590498160b2a8f9942ec76d27c3f219da76abcb3ba0c8e0d524c77e4fd30fb40"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/5d1dad22-23e6-4abf-b521-ec8b0e6f4037"
      sha256 "6e2ec72a29119d4afc3ac70bad998eed6b14049d271482717f2d2aa5c62e751c"
    else
      url "https://forgejo.coilysiren.me/attachments/7b9e13ba-3c43-4ce5-b810-1997eb109c01"
      sha256 "590498160b2a8f9942ec76d27c3f219da76abcb3ba0c8e0d524c77e4fd30fb40"
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
