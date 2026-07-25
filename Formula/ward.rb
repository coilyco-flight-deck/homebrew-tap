class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.808.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/c4d5b023-8b4d-467e-afc0-93ba0ebf69eb"
      sha256 "6edc415b6cfffa6c2a8c5ddd540a885645e9f035e8385c7693b99a6d5da493da"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/253597fd-18c7-42f8-a9a1-1eb1cbc682f3"
        sha256 "ff46dede908af39debdb3514b3860eaf7c8961d43939203434dc28716cb64fe4"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/30d6934a-4e1a-4d94-8fa8-67d9c926343c"
      sha256 "8de0f9158873ccab90065cd200b426d00a7b4fe6ffeff337f8797216452d0ff8"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/20c8ef2d-ac08-4be0-8d7e-805c5814a545"
        sha256 "567732e97b59b1f3da3923245d94be3b902b670ccec113296984fa1c150e6706"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/253597fd-18c7-42f8-a9a1-1eb1cbc682f3"
      sha256 "ff46dede908af39debdb3514b3860eaf7c8961d43939203434dc28716cb64fe4"
    else
      url "https://forgejo.coilysiren.me/attachments/20c8ef2d-ac08-4be0-8d7e-805c5814a545"
      sha256 "567732e97b59b1f3da3923245d94be3b902b670ccec113296984fa1c150e6706"
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
