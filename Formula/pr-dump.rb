# Formula for pr-dump
class PrDump < Formula
  desc "Dump GitHub PR context (metadata, comments, diffs) for LLM review"
  homepage "https://github.com/CheerChen/pr-dump"
  url "https://github.com/CheerChen/pr-dump/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "ce76b7ebaba5f74a56c5f2c52b3d355f06d3635983c13d4e87c852269347e8f2"
  license "MIT"

  deprecate! date: "2026-03-19", because: "merged into ctxd"

  depends_on "gh"
  depends_on "jq"

  def install
    bin.install "pr-dump.sh" => "pr-dump"
  end

  test do
    assert_match "pr-dump version", shell_output("#{bin}/pr-dump --version")
  end
end
