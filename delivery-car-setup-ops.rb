class DeliveryCarSetupOps < Formula
  desc "Delivery Car OPS setup (Aircall, Slack, Chrome, printer driver)"
  homepage "https://deliverycar.fr"
  url "https://github.com/deliverycar/homebrew-deliverycar/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  version "1.2.0"

  def install
    system "brew", "install", "--cask", "aircall"
    system "brew", "install", "--cask", "slack"
    system "brew", "install", "--cask", "google-chrome"

    dmg = buildpath/"assets/drivers/MX-C52d_2111a_MacPS.dmg"
    raise "Driver DMG not found: #{dmg}" unless dmg.exist?

    out = Utils.safe_popen_read("hdiutil", "attach", dmg.to_s, "-nobrowse", "-readonly")
    mountpoint = out.lines.reverse.find { |l| l.include?("/Volumes/") }&.split("\t")&.last&.strip
    raise "Mountpoint not found" if mountpoint.to_s.empty?

    pkg = Dir["#{mountpoint}/**/*.pkg"].first
    raise "No .pkg found in mounted DMG" if pkg.to_s.empty?

    system "sudo", "installer", "-pkg", pkg, "-target", "/"
    system "hdiutil", "detach", mountpoint
  end
end