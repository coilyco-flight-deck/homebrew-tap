class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.796.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/578854aa-9582-452c-916f-3c3848840265"
      sha256 "d29ffb7dee13c383030d4813bee383f6ad196818725856f96a431891bc02b605"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/de81052e-c8cb-42bc-b282-500634abc56a"
        sha256 "961a4abc497633d93e543bc000ccc2821e05f5edfe58a1f0c0d198c3eb9f6380"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/a508a286-d7c0-4d95-bd4e-8392aa5b78ff"
      sha256 "e0107dd7e9f3fb9a3707fac2aee2a17cff917f87b739f332dd7cf944d87d0ddd"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/b7e68530-8b4a-4338-9f13-fe8600ec16f6"
        sha256 "737a717a979be394c3e78b51259cde5f9333d0e4a9e0148e9a86fffcde615e52"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/de81052e-c8cb-42bc-b282-500634abc56a"
      sha256 "961a4abc497633d93e543bc000ccc2821e05f5edfe58a1f0c0d198c3eb9f6380"
    else
      url "https://forgejo.coilysiren.me/attachments/b7e68530-8b4a-4338-9f13-fe8600ec16f6"
      sha256 "737a717a979be394c3e78b51259cde5f9333d0e4a9e0148e9a86fffcde615e52"
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
