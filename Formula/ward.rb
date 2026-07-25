class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.810.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/d08391ae-db94-4d23-a6f6-ca9ca2683873"
      sha256 "bd365e5a6a8859595d62db6b4bbb96f792c417cc4e8623176d271f2c5c94f391"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/70fd76f1-afa6-465c-b426-20ee415c3765"
        sha256 "78f70a8df6e6ee4f7ddc37b6a1303b4f98dea112d8cb7ca708f5e49d1199124c"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/0d077760-c61c-42f8-88d5-d92a936843a5"
      sha256 "831464c04d9e4785a79061545274daf17d858d9c771058b719e9fc902d96cb7a"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/7a356483-3b7e-485d-9120-48bd48d86f1d"
        sha256 "9bdd07eda576f99e1462177e07580858425a8f5e987b8bae0e2d5da91c28539a"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/70fd76f1-afa6-465c-b426-20ee415c3765"
      sha256 "78f70a8df6e6ee4f7ddc37b6a1303b4f98dea112d8cb7ca708f5e49d1199124c"
    else
      url "https://forgejo.coilysiren.me/attachments/7a356483-3b7e-485d-9120-48bd48d86f1d"
      sha256 "9bdd07eda576f99e1462177e07580858425a8f5e987b8bae0e2d5da91c28539a"
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
