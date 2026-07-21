class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.785.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/3fd150bc-5f3f-468d-a011-3f1ccb90889a"
      sha256 "b539003901a841d5ce7b195f63c11592785530e17a0ff17a25119eb116edec90"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/84fec35f-423d-428a-b93b-58a9f530e137"
        sha256 "6120528bfe8a0c42231384da068f3bf836f1a0d8d2d85db22b5d1fce1df08a82"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/34486b08-3e5d-433b-8dda-25060ec66dfa"
      sha256 "05cb9788da79206398db3f48b4e19b2d97fbd960367b76fbf83e748d9b9b2817"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/b50b5281-9a45-4d45-849c-768b6700e2e3"
        sha256 "1558683eb55b45ddbfcc3614590b54ca421df7e242085bc809d7346f1e517b16"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/84fec35f-423d-428a-b93b-58a9f530e137"
      sha256 "6120528bfe8a0c42231384da068f3bf836f1a0d8d2d85db22b5d1fce1df08a82"
    else
      url "https://forgejo.coilysiren.me/attachments/b50b5281-9a45-4d45-849c-768b6700e2e3"
      sha256 "1558683eb55b45ddbfcc3614590b54ca421df7e242085bc809d7346f1e517b16"
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
