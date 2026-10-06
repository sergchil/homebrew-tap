cask "browserbro" do
  version "1.2.0"
  sha256 "01bf5727c9102d369229c47bcab4eff423705f54d50db261bb7b7528536dafc8"

  url "https://github.com/sergchil/browserbro/releases/download/v#{version}/BrowserBro.zip"
  name "BrowserBro"
  desc "Opens every link in the right browser and profile"
  homepage "https://sergchil.github.io/browserbro/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "BrowserBro.app"

  # BrowserBro is ad-hoc signed and not notarized. Remove the quarantine flag so
  # macOS does not block the first launch.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/BrowserBro.app"], must_succeed: false
  end

  uninstall quit: "com.sergchil.BrowserBro"

  zap trash: [
    "~/Library/Application Support/BrowserBro",
    "~/Library/Preferences/com.sergchil.BrowserBro.plist",
  ]
end
