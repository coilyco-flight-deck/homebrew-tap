class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.809.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/08a36218-8703-4a91-b3bc-707bf7a8a00e"
      sha256 "451aadd39c87c6ac248c7d0bcc3d3f419b1df2e3e8e71e28b2ed9ec84f7a8ecd"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/36fc6057-4f34-4aad-b8c8-c619c362e779"
        sha256 "e89591b912661931ee31008a81fcbf9a6a59ae07d4adb15f9c23416db06bc226"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/73cdb7a9-d19d-4e99-8c5a-7bdc2867165e"
      sha256 "2539b8090a630bdb2dc8d5e17e285f40b5800f0593565df25572d33ceafd8714"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/5f229bde-807c-4fb7-8d34-a61af92f0d02"
        sha256 "f0442dcc6ead81ea0d6c40aae7a64d93dbaa19563cb7a3e2c3140f89c0bb1ee5"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/36fc6057-4f34-4aad-b8c8-c619c362e779"
      sha256 "e89591b912661931ee31008a81fcbf9a6a59ae07d4adb15f9c23416db06bc226"
    else
      url "https://forgejo.coilysiren.me/attachments/5f229bde-807c-4fb7-8d34-a61af92f0d02"
      sha256 "f0442dcc6ead81ea0d6c40aae7a64d93dbaa19563cb7a3e2c3140f89c0bb1ee5"
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
