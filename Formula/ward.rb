class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.450.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.450.0/ward-darwin-arm64"
      sha256 "163738d9cce52884064c8c01a582f471efb105b38a7ef2b0b03c1276e1fef8ba"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.450.0/ward-darwin-amd64"
      sha256 "b1aa49949eb4fa0a087c6c4b43846dd2a93333fc38571fd3cef334c65b60c8d2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.450.0/ward-linux-arm64"
      sha256 "0c2da03f36ac55811689220980af233dca067757668ec4e9f774a47e4142e0e7"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.450.0/ward-linux-amd64"
      sha256 "f53afb10e497ad72128f6a5f00f1ab967f3e6f50d63e07ea651d6a694adc7748"
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
