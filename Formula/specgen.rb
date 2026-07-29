class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.128.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.128.0/specgen-darwin-amd64"
      sha256 "16deac8ac7b8cb865ddfcf2751ef35b432ccc924a51fb859f8fd737b121a6c2e"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.128.0/specgen-darwin-arm64"
      sha256 "b9dc6c6ac86d305ac207a470ea01a76f411d9e02edb3a42608bdc8cbd0785ff5"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.128.0/specgen-linux-amd64"
      sha256 "cc4ba7e7e469a494f0cecb2edfae3308a0e36f050ff27788fb9d361a5e7cd754"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.128.0/specgen-linux-arm64"
      sha256 "33ca3bf49d98d541cdc1c46d74726adfc89ee62f19d76928bf1de79d0c90ba97"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
