class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/archive/v0.436.0.tar.gz"
  sha256 "b957cd3bd1e2e6a49dc03376390ec0317d7f0378783852c9a71f614e3214d7d5"
  license "MIT"
  head "https://forgejo.coilysiren.me/coilyco-flight-deck/ward.git", branch: "main"

  depends_on "go" => :build

  def install
    # The source is a tarball (no .git), so disable Go's VCS stamping for both the
    # direct build and the driver's internal build. See ward#116.
    ENV["GOFLAGS"] = "-buildvcs=false"
    # GOPROXY bypass for fresh cli-guard pseudo-versions. See docs/homebrew-build.md.
    ENV["GOPROXY"] = "direct"
    ENV["GOSUMDB"] = "off"
    ENV["GOPRIVATE"] = "forgejo.coilysiren.me"
    ldflags = "-s -w -X main.Version=v#{version}"
    system "go", "build", "-trimpath",
           "-ldflags", ldflags,
           "-o", bin/"ward",
           "./cmd/ward"

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
