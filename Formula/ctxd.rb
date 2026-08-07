class Ctxd < Formula
  desc "Unified context dumper for LLM — GitHub PR, Slack, Confluence, Jira"
  homepage "https://github.com/CheerChen/ctxd"
  url "https://github.com/CheerChen/ctxd/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "88cdb6c12424cd5f85ba97f8d4df99169e07f3d172980d9b5630e0f9011c4175"
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
