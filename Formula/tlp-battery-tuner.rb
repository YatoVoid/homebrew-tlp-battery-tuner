class TlpBatteryTuner < Formula
  desc "Battery-focused TLP tuning config installer"
  homepage "https://github.com/YatoVoid/tlp-battery-tuner"
  url "https://github.com/YatoVoid/tlp-battery-tuner/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "d7b407a9edd31ddb121fad314bf63cfa0f1a104b09de274fe2fdbbebcdf2a871"
  license "MIT"

  depends_on :linux

  def install
    bin.install "install.sh" => "tlp-battery-tuner-install"
    bin.install "uninstall.sh" => "tlp-battery-tuner-uninstall"
    pkgshare.install "tlp.d/00-battery-tuner.conf"
    doc.install "README.md"
  end

  def caveats
    <<~EOS
      This formula only stages the installer. As an unprivileged Homebrew
      formula it can't write to /etc or manage systemd services on its own.

      To apply the TLP battery-tuning config, run:
        sudo #{opt_bin}/tlp-battery-tuner-install

      To remove it:
        sudo #{opt_bin}/tlp-battery-tuner-uninstall

      Requires `tlp` itself, which the installer will try to install via
      your distro's package manager (apt, dnf, zypper, pacman, or apk).
    EOS
  end

  test do
    assert_path_exists bin/"tlp-battery-tuner-install"
    assert_path_exists pkgshare/"00-battery-tuner.conf"
  end
end
