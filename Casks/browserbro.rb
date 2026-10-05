cask "browserbro" do
  version "1.0.0"
  sha256 "fc07ac7204012e06d6c0ff835792933763094dbf5f51186f9ea6c80f841f952f"

  url "https://github.com/sergchil/browserbro/releases/download/v#{version}/BrowserBro.zip"
  name "BrowserBro"
  desc "Opens every link in the right browser and profile"
  homepage "https://sergchil.github.io/browserbro/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

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
