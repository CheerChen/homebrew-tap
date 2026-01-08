class ConfluenceDump < Formula
  desc "Export Confluence pages to Markdown for LLM context"
  homepage "https://github.com/CheerChen/confluence-dump"
  url "https://github.com/CheerChen/confluence-dump/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "aaa5857fb06eafd1c9f2dfb300d7e183afee69d8a7c63017c9ce6a5880f56288"
  license "MIT"

  depends_on "uv"

  def install
    libexec.install Dir["*"]
    (bin/"confluence-dump").write <<~EOS
      #!/bin/bash
      export PROJECT_DIR_OVERRIDE="#{libexec}"
      exec "#{Formula["uv"].opt_bin}/uv" run --frozen --project "#{libexec}" confluence-dump "$@"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/confluence-dump --version")
  end
end
