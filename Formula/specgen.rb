class Specgen < Formula
  desc "Generate guarded CLIs from KDL policy and committed API locks"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard"
  version "0.127.0"
  license "MIT"

  on_macos do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.127.0/specgen-darwin-amd64"
      sha256 "eb3286bddd6f02732faeff7ad22d4832a9f8ed51070e5901b6c38d37798e3577"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.127.0/specgen-darwin-arm64"
      sha256 "39eba25124484236c0f9c58adf2b4a4afd60aebdcd9216b0b195a1b2b5e45818"
    end
  end
  on_linux do
    on_intel do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.127.0/specgen-linux-amd64"
      sha256 "afbd8a2503cbd172e57662a2b16fb86c2c90403007dad3ea283896f467c2ae0a"
    end
    on_arm do
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/releases/download/v0.127.0/specgen-linux-arm64"
      sha256 "3aa1a0ef8da9f5f8216906939b82a1053058222d1959dc7853ac2b0989ffd46a"
    end
  end

  def install
    bin.install Dir["specgen-*"].first => "specgen"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/specgen --version")
  end
end
