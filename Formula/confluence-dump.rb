class ConfluenceDump < Formula
  desc "Export Confluence pages to Markdown for LLM context"
  homepage "https://github.com/CheerChen/confluence-dump"
  url "https://github.com/CheerChen/confluence-dump/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "3c39e51ade098d9120b42b651203e4a67176cf09f182cdd099f1f27aa23dccaa"
  license "MIT"

  depends_on "uv"

  def install
    libexec.install Dir["*"]
    (bin/"confluence-dump").write <<~EOS
      #!/bin/bash
      export PROJECT_DIR_OVERRIDE="#{libexec}"
      exec "#{Formula[\"uv\"].opt_bin}/uv" run --frozen --project "#{libexec}" confluence-dump "$@"
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/confluence-dump --version")
  end
end
