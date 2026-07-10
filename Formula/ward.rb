class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.545.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.545.0/ward-darwin-arm64"
      sha256 "6880ffeade89db004e4b9985e54dfa7e48ad8989cb025ec07d579bd523e7a5ec"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.545.0/ward-darwin-amd64"
      sha256 "ded349a5fbb249214b7e1824caaf6a381c9a081daf9600cd72bf3524b885acd2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.545.0/ward-linux-arm64"
      sha256 "024d3310078972c7d6bfd7b054a3881f877d09d3b90a1b4cb2276994b01880f0"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.545.0/ward-linux-amd64"
      sha256 "8b9696be0ee101e71ab8e78706b3f0dc19ce6592769a5d94662db6965a2a3482"
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

    bin.install_symlink "ward" => "warded"

  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
