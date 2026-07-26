class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.813.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/4a1f1e08-b416-4984-99f2-5687309f1010"
      sha256 "b71eee3ed9735bb51e02b253a23ced36ce41a60b613a412348ba52c56f69e52e"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/3781a803-8113-4295-99d3-342b89817420"
        sha256 "ff91d65fe6b00f940cebea25757ef68f814a34411d160efa7403e4f957bbb49a"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/ea135240-b10e-47f9-ad0e-f3a72c7789d0"
      sha256 "6fa0f4227ea5af012910dbce8dc3f45c1f3b535999bf6bcdd228898757c45435"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/0ff537fb-ed02-46c3-b210-a6da88165504"
        sha256 "b99d521e8a36485991c491aa246061419e472386488bcec327f0a117ff935bcc"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/3781a803-8113-4295-99d3-342b89817420"
      sha256 "ff91d65fe6b00f940cebea25757ef68f814a34411d160efa7403e4f957bbb49a"
    else
      url "https://forgejo.coilysiren.me/attachments/0ff537fb-ed02-46c3-b210-a6da88165504"
      sha256 "b99d521e8a36485991c491aa246061419e472386488bcec327f0a117ff935bcc"
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
