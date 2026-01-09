class ConfluenceDump < Formula
  desc "Export Confluence pages to Markdown for LLM context"
  homepage "https://github.com/CheerChen/confluence-dump"
  url "https://github.com/CheerChen/confluence-dump/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "f71670e705435c3f5257389eb4a80d9489c92d9fd4741e92f3e411332c7ad2fc"
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
