class DeliveryCarSetupDev < Formula
  desc "Delivery Car full dev environment setup"
  homepage "https://deliverycar.fr"
  url "https://github.com/deliverycar/homebrew-deliverycar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "SHA256_A_REMPLACER"
  version "1.0.0"

  depends_on "git"
  depends_on "node"

  def install
    system "brew", "install", "--cask", "visual-studio-code"
    system "brew", "install", "--cask", "slack"
    system "brew", "install", "--cask", "google-chrome"
    system "brew", "install", "--cask", "insomnia"
    system "brew", "install", "--cask", "figma"
    system "brew", "install", "--cask", "notion"
  end
end