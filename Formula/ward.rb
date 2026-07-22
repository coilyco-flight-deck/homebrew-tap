class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.788.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/8dc40221-079e-4c8d-a639-7078f0e53b9c"
      sha256 "f36eb7f8175cb00f5f3aa15860f6d4cb89cda2131081db4707a114ad91c58783"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/6514ca4f-1424-4ad0-baab-79c498fe9a47"
        sha256 "405421d9609a55713eed744e95702547c7b45545d119858f09fab51a9b5a88e2"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/550fbb75-c4f1-4a8c-b2ee-6ee828f7af49"
      sha256 "ecd58c96ef7af828fb71ba151eb2f8eee3c0ffbb5bc070417e2b7885d24ede00"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/63806f7b-09b1-4e63-bb71-2294cb741eb5"
        sha256 "53b2bdf189196f54a21fc94b0126e7f5c0773d6f7c6ae89b195276cc1ae233fb"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/6514ca4f-1424-4ad0-baab-79c498fe9a47"
      sha256 "405421d9609a55713eed744e95702547c7b45545d119858f09fab51a9b5a88e2"
    else
      url "https://forgejo.coilysiren.me/attachments/63806f7b-09b1-4e63-bb71-2294cb741eb5"
      sha256 "53b2bdf189196f54a21fc94b0126e7f5c0773d6f7c6ae89b195276cc1ae233fb"
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
