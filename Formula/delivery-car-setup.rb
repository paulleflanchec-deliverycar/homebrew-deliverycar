class DeliveryCarSetupDev < Formula
  desc "Delivery Car full dev environment setup"
  homepage "https://deliverycar.fr"
  url "https://github.com/deliverycar/homebrew-deliverycar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
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
    system "brew", "install", "--cask", "docker"
  end
end