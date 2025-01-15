class CloudLocalds < Formula
  desc "Generate cloud-init disk images (patched for macOS)"
  homepage "https://github.com/canonical/cloud-utils"
  url "https://github.com/canonical/cloud-utils/raw/main/bin/cloud-localds"
  version "0.33"
  sha256 "936eeaf470b208418689a604a1ae7d0dac3f45ea24d68c2c187eac8957543157"
  depends_on "gnu-getopt"
  depends_on "cdrtools"

  def install
    # Rename the downloaded script to a standard file name
    mv "cloud-localds", "cloud-localds.orig"

    # Write the script into our buildpath
    (buildpath/"cloud-localds").write <<~EOS
      #{File.read("cloud-localds.orig")}
    EOS

    # Replace 'genisoimage' with 'mkisofs' for macOS (cdrtools)
    inreplace "cloud-localds", "genisoimage", "mkisofs"

    # Make the script executable
    chmod 0755, "cloud-localds"

    # Install the script into the Homebrew bin directory
    bin.install "cloud-localds"
  end

  def caveats
    <<~EOS
      cloud-localds has been patched to use gnu-getopt and mkisofs on macOS.
      If you encounter any further argument-parsing issues or ISO-generation
      issues, ensure that:
        1. gnu-getopt is available in your $PATH , Check brew message for further information as it is installed as keg only.
        2. You have cdrtools installed for mkisofs.
    EOS
  end

  test do
    # A basic test to ensure the script runs and shows usage information.
    # This won't actually create an image, but it checks argument parsing.
    system "#{bin}/cloud-localds", "--help"
  end
end

