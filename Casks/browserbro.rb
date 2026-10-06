cask "browserbro" do
  version "1.1.0"
  sha256 "7c8bab7a54fd71d9740dc4282f06e3226d2937a4eb29b313d8ae45b3cdaaf687"

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
