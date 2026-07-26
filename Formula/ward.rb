class Ward < Formula
  desc "A contributor-facing cli-guard consumer"
  homepage "https://forgejo.coilysiren.me/coilyco-flight-deck/ward"
  version "0.814.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/92d4a787-bfb8-470a-bc8d-b42c253751b3"
      sha256 "f8afc3b773bd4fb7ddd4cbb1e55675a183dd2ef21bf3be5427443ced35577022"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/6a91874b-ffb9-42fc-ac9e-ae20d28e64b7"
        sha256 "0351fc736e36b0d9c93afc0ab50fdbc1da908316a49855af5b861b4155433129"
      end
    else
      url "https://forgejo.coilysiren.me/attachments/a6d8da1b-5201-4781-820b-0893181114fb"
      sha256 "222a9de46d614ae4d3f35d56eee47fb04ce7529f66a7b1c0d52e5cf37ef2b058"
      resource "ward-linux" do
        url "https://forgejo.coilysiren.me/attachments/cda4b17e-d4b4-45d5-98d1-34ddc551a743"
        sha256 "f9854aecad57c36458f92bdf5fde0025e1403360ef377f30d6262f6f68f802e3"
      end
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://forgejo.coilysiren.me/attachments/6a91874b-ffb9-42fc-ac9e-ae20d28e64b7"
      sha256 "0351fc736e36b0d9c93afc0ab50fdbc1da908316a49855af5b861b4155433129"
    else
      url "https://forgejo.coilysiren.me/attachments/cda4b17e-d4b4-45d5-98d1-34ddc551a743"
      sha256 "f9854aecad57c36458f92bdf5fde0025e1403360ef377f30d6262f6f68f802e3"
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
