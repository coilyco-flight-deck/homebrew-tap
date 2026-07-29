class Aos < Formula
  desc "Agent runtime composition root for Agentic OS"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os"
  version "0.126.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.126.0/aos-darwin-arm64"
      sha256 "dc8ac4a0d9da0ff8b13385d429eb16176bc0c7a4c03206ec92529d7e5a5aeb1e"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.126.0/aosguard-darwin-arm64"
        sha256 "e4f9a203904aac8a246074035dad67674d823ae91924b199b913511e8c19d8f4"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.126.0/aos-linux-amd64"
      sha256 "9d5e5589a366dd6fa13bb77c2f85f61af393a2260bb4fa743ce45c68dd080226"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.126.0/aosguard-linux-amd64"
        sha256 "3586325594d529f42680e65204d5ef442f9b3aabda710de5c4b737640abb4781"
      end
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.126.0/aos-linux-arm64"
      sha256 "66d22561966caf711661db9798463db6494918bdbd555671102354814cc707bc"
      resource "aosguard" do
        url "https://forgejo.coilysiren.me/coilyco-flight-deck/agentic-os/releases/download/aos-v0.126.0/aosguard-linux-arm64"
        sha256 "d1827bf387ba203262fcc57faa716cad4b854f85895a47344c61b34423c996eb"
      end
    end
  end

  def install
    bin.install Dir["aos-*"].first => "aos"
    resource("aosguard").stage { bin.install Dir["aosguard-*"].first => "aosguard" }
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aos version")
    assert_match version.to_s, shell_output("#{bin}/aosguard --version")
  end
end
