# Formula for pr-dump
class PrDump < Formula
  desc "Dump GitHub PR context (metadata, comments, diffs) for LLM review"
  homepage "https://github.com/CheerChen/pr-dump"
  url "https://github.com/CheerChen/pr-dump/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "848486830d2ae1446294b03051ca7363ca15a75931a0f4f06b4a1127e7137de5"
  license "MIT"

  depends_on "gh"
  depends_on "jq"

  def install
    bin.install "pr-dump.sh" => "pr-dump"
  end

  test do
    assert_match "pr-dump version", shell_output("#{bin}/pr-dump --version")
  end
end
