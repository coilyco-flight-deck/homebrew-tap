class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.816.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/d76e9916-1593-422b-b948-819179c87718"
      sha256 "ab5c41c266b4e4c45040fdfa68983d8d9df44cfcf0dd153f46a8415c21ac9a85"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/7fe5c6f3-8d9c-4cd3-a73e-1869670ae357"
        sha256 "66664ccccc67e83939262281654cbfd62197d119895a1f072f40b4a083cef121"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/3e38498d-1f1a-4dd0-a6e0-11784bc3fd5a"
      sha256 "3b3e7fbd2f96423f1ad328dd56908488fd2eeb394b24f163af458ed6445f029d"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/3adbdfab-6d46-446a-af7b-252e1f2807de"
        sha256 "cabf79a19762cd1e910c4c442113abdd12458822566b7aff800068d47fa5dbd3"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/7fe5c6f3-8d9c-4cd3-a73e-1869670ae357"
      sha256 "66664ccccc67e83939262281654cbfd62197d119895a1f072f40b4a083cef121"
    else
      url "https://forgejo.coilysiren.me/attachments/3adbdfab-6d46-446a-af7b-252e1f2807de"
      sha256 "cabf79a19762cd1e910c4c442113abdd12458822566b7aff800068d47fa5dbd3"
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
