class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.493.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.493.0/ward-darwin-arm64"
      sha256 "ce606226fe97960b0c743fdb32001f2a56d9a84ce4f98012115544291fb31a97"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.493.0/ward-darwin-amd64"
      sha256 "38a3684c249846a5b3a8a4dd3b80bc2164de780fefaa4cc6ee0d6992482476ea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.493.0/ward-linux-arm64"
      sha256 "381206b85a01472486816f6a212d356e1eda28ecbdf51950268e7c05d44a2c03"
    else
      url "https://forgejo.coilysiren.me/coilyco-flight-deck/ward/releases/download/v0.493.0/ward-linux-amd64"
      sha256 "8eebf60fe883087abb0e151c768aabe4dbc3d132d4539e9c4a25ddf2e44b6a27"
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
