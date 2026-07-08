class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.451.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.451.0/ward-darwin-arm64"
      sha256 "aaa9014c8cbd9bf252b1b199a5c774ad1c2c25da3a819ba111077b8486a92009"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.451.0/ward-darwin-amd64"
      sha256 "65bd90d40d00533d164423a09b9b192a09065ceb66f65dd19203dad8b1f95ec4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.451.0/ward-linux-arm64"
      sha256 "d7e9a621be0074e56397ac12b85aeec707c3dfc39a990fc3ec4ee154513fd8eb"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.451.0/ward-linux-amd64"
      sha256 "728caa08cfd4ae101b9eb47c5e0507d41781f769c28a062aa403a3a1c439f727"
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

    # Public-face shim: invoked as `warded`, ward's multicall rewrites argv to
    # `ward agent <args>` (one binary, not a second build). The in-binary and
    # container install paths already ship this; the host brew path needs the
    # symlink on PATH too. See ward#247, ward#282 / docs/agent.md.
    bin.install_symlink "ward" => "warded"

    # The formula installs only `ward` (+ the `warded` shim). The `ward-kdl`
    # authoring binary is deliberately NOT installed: its surfaces are already
    # embedded in `ward`, so end users need neither it nor the tier CLIs. Spec
    # authors build it from a ward checkout with `make build-ward-kdl` (ward#455,
    # docs/ward-kdl-authoring.md).
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
