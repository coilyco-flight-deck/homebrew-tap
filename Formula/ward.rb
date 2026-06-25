class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/archive/v0.167.0.tar.gz"
  sha256 "bcd298dc4525af78cd45d7c909a30d6d6b6ccce896ae28458395949d4e6ec5db"
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
    # `ward drive <args>` (one binary, not a second build). The in-binary and
    # container install paths already ship this; the host brew path needs the
    # symlink on PATH too. See ward#277 / docs/drive.md.
    bin.install_symlink "ward" => "warded"

    # ward-kdl is a no-code specverb-gen consumer: build it via the driver from
    # the committed locks (no online `lock` step) and stamp the same version as
    # ward. The driver ref tracks the Makefile so the two never drift.
    ref = File.read("Makefile")[/^REF\s*\?=\s*(\S+)/, 1] || "v0.26.0"
    system "go", "run",
           "forgejo.coilysiren.me/coilyco-flight-deck/cli-guard/cmd/specverb-gen@#{ref}",
           "build",
           "--guardfile", "cmd/ward-kdl/ward-kdl.forgejo.guardfile.kdl",
           "--out", bin,
           "--set-version", "v#{version}"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/ward version")
    assert_match "v#{version}", shell_output("#{bin}/ward-kdl --version")
    # The warded multicall shim must be on PATH and point at the ward binary.
    assert_predicate bin/"warded", :symlink?
    assert_equal (bin/"ward").realpath, (bin/"warded").realpath
  end
end
