class SlackThreadDump < Formula
  desc "Export Slack threads to text or Markdown"
  homepage "https://github.com/CheerChen/slack-thread-dump"
  url "https://github.com/CheerChen/slack-thread-dump/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "f9595cf867a2bf385dada335949af37968cb96d470dd102bb436aea5b6885119"
  license "MIT"

  depends_on "jq"

  def install
    bin.install "slack-thread-dump.sh" => "slack-thread-dump"
  end

  test do
    assert_match "slack-thread-dump version", shell_output("#{bin}/slack-thread-dump --version")
  end
end
