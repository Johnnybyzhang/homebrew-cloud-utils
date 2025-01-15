class CloudLocalds < Formula
  desc "Generate cloud-init disk images (patched for macOS)"
  homepage "https://github.com/canonical/cloud-utils"
  url "https://github.com/canonical/cloud-utils/raw/main/bin/cloud-localds"
  version "0.33"
  sha256 "936eeaf470b208418689a604a1ae7d0dac3f45ea24d68c2c187eac8957543157"

  depends_on "cdrtools"

  def install
    bin.install "cloud-localds"
    # Apply patch to replace 'genisoimage' with 'mkisofs'
    inreplace bin/"cloud-localds", "genisoimage", "mkisofs"
    chmod "+x", bin/"cloud-localds"
  end
end

