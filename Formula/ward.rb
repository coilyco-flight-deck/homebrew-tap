class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.800.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/56ee15a5-a252-49aa-abff-3526cc77e432"
      sha256 "f7f02cfe9983b141c33ea8a796bafe57f0b80748be4dd61c5f9ee5b2522da2c7"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/53e7a836-8dc2-46e2-9691-2391a5c408d7"
        sha256 "6645c042f72f0e0343cd26217917a909d8a6bd4a8732cae2b67eb7878be6a16a"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/0bec216a-2b5e-4ef5-8211-3ee8c8cfe24b"
      sha256 "b61663a33913f0cd0b28fdbd9da34cb79c70ba53426f1655153e1ae306853f25"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/40e7f5b9-0e0f-46f2-a9ae-abb372e7d344"
        sha256 "20623ba22a14ceb69ef19bd1d4e2e41dc153dbb7423fda8b9e3e9962aad224aa"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/53e7a836-8dc2-46e2-9691-2391a5c408d7"
      sha256 "6645c042f72f0e0343cd26217917a909d8a6bd4a8732cae2b67eb7878be6a16a"
    else
      url "https://forgejo.coilysiren.me/attachments/40e7f5b9-0e0f-46f2-a9ae-abb372e7d344"
      sha256 "20623ba22a14ceb69ef19bd1d4e2e41dc153dbb7423fda8b9e3e9962aad224aa"
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
