class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.654.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.654.0/ward-darwin-arm64"
      sha256 "29ca4b0f925987c7f2f56ae8bfebb778599d7d5814e5fa7a627f80dbab7949a4"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.654.0/ward-darwin-amd64"
      sha256 "cde2ca4726c190bad8e29fe5c6e7bb0295db87d91df1288cc088b74021dd9eba"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.654.0/ward-linux-arm64"
      sha256 "bcd951687ec12e41dd4657701fc497233edb404717f02b4f2cd9974a3feb3527"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.654.0/ward-linux-amd64"
      sha256 "bead44bf7fffd8c52e86353faea42e58422d7a67b976ef93547bda34b60b8bea"
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
