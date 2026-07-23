class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.797.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/3c5c18e5-bc58-4e0b-a67d-0e718a64c95f"
      sha256 "bd636fad675f14a0e2e00dbfe0d0652a08183543700c601a12d7d59c9b3c3258"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/ba3a154d-f6bb-47f9-a101-370e81e9a110"
        sha256 "bc7dd3cf91289e99743739d308f6bd7724fd9abd5337593e4117c8dad85fd7aa"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/324632a3-81fb-440c-8179-a2fd1cc80d76"
      sha256 "1f784be125887969f67d0930a39986903a03b039d90cd98618e6607f1671a18a"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/a4fd13c6-5060-4202-b695-2b32a8d76875"
        sha256 "d98ffcc66928fe18e2152966095e118fb76b2d039ab597dc19187cdcdf0a83cd"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/ba3a154d-f6bb-47f9-a101-370e81e9a110"
      sha256 "bc7dd3cf91289e99743739d308f6bd7724fd9abd5337593e4117c8dad85fd7aa"
    else
      url "https://forgejo.coilysiren.me/attachments/a4fd13c6-5060-4202-b695-2b32a8d76875"
      sha256 "d98ffcc66928fe18e2152966095e118fb76b2d039ab597dc19187cdcdf0a83cd"
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
