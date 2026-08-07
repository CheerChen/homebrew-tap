class Ctxd < Formula
  desc "Unified context dumper for LLM — GitHub PR, Slack, Confluence, Jira"
  homepage "https://github.com/CheerChen/ctxd"
  url "https://github.com/CheerChen/ctxd/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "c39441b6a646ff606d31cb9483c66897bd1353d00caf9d79d398246bbfbd95e5"
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
      zsh globs `?` and `[` in unquoted arguments, so pasted URLs fail with
      "no matches found". Add this to ~/.zshrc:

        eval "$(ctxd init zsh)"

      bash and fish need no setup, but still treat a bare `&` as backgrounding
      — quote URLs containing `&` or `?` in those shells.

      Each source reads its own credential from the environment or
      ~/.config/ctxd/config: GITHUB_TOKEN, SLACK_TOKEN, CONFLUENCE_BASE_URL /
      CONFLUENCE_EMAIL / CONFLUENCE_API_TOKEN.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ctxd --version")
  end
end
