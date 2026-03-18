class Ctxd < Formula
  desc "Unified context dumper for LLM — GitHub PR, Slack, Confluence, Jira"
  homepage "https://github.com/CheerChen/ctxd"
  url "https://github.com/CheerChen/ctxd/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "2bcbf20f00ab1b5bd11a92199f4e64bcf88cb603e2a71c4643e256394aacf8a9"
  license "MIT"

  depends_on "uv"

  def install
    libexec.install Dir["*"]
    (bin/"ctxd").write <<~EOS
      #!/bin/bash
      exec "#{Formula["uv"].opt_bin}/uv" run --quiet --frozen --project "#{libexec}" ctxd "$@"
    EOS
  end

  def caveats
    <<~EOS
      Add to your shell config for the short alias `ctx`:

        # zsh
        eval "$(ctxd init zsh)"

        # bash
        eval "$(ctxd init bash)"

        # fish
        ctxd init fish | source
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ctxd --version")
  end
end
