class DeliveryCarSetupOps < Formula
  desc "Delivery Car OPS setup (Aircall, Slack, Chrome, printer driver)"
  homepage "https://deliverycar.fr"
  url "https://github.com/paulleflanchec-deliverycar/homebrew-deliverycar/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "576ca228bd846fc64a9b7b3ccbf30e56882d81cdebeb51ccefd4729e31a12570"
  version "1.2.0"

  def install
    dmg = buildpath/"assets/driver/MX-C52d_2111a_MacPS.dmg"
    raise "Driver DMG not found: #{dmg}" unless dmg.exist?

    pkgshare.install dmg

    (bin/"delivery-car-setup-ops").write <<~BASH
      #!/bin/bash
      set -euo pipefail

      brew_bin="#{HOMEBREW_PREFIX}/bin/brew"
      if [ ! -x "$brew_bin" ]; then
        brew_bin="$(command -v brew || true)"
      fi

      if [ -z "$brew_bin" ]; then
        echo "brew not found." >&2
        exit 1
      fi

      "$brew_bin" install --cask aircall
      "$brew_bin" install --cask slack
      "$brew_bin" install --cask google-chrome

      dmg="#{opt_pkgshare}/MX-C52d_2111a_MacPS.dmg"
      if [ ! -f "$dmg" ]; then
        echo "Driver DMG not found: $dmg" >&2
        exit 1
      fi

      out="$(hdiutil attach "$dmg" -nobrowse -readonly)"
      mountpoint="$(printf "%s\\n" "$out" | awk -F "\\t" '/\\/Volumes\\// {mp=$NF} END {print mp}')"
      if [ -z "$mountpoint" ]; then
        echo "Mountpoint not found." >&2
        exit 1
      fi

      pkg="$(find "$mountpoint" -name '*.pkg' -print -quit)"
      if [ -z "$pkg" ]; then
        echo "No .pkg found in mounted DMG." >&2
        hdiutil detach "$mountpoint" >/dev/null 2>&1 || true
        exit 1
      fi

      sudo installer -pkg "$pkg" -target /
      hdiutil detach "$mountpoint"
    BASH
    chmod 0755, bin/"delivery-car-setup-ops"
  end

  def caveats
    <<~EOS
      Run the OPS setup command after installation:
        delivery-car-setup-ops
    EOS
  end
end
