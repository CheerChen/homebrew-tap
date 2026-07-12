class Ctxd < Formula
  desc "Unified context dumper for LLM — GitHub PR, Slack, Confluence, Jira"
  homepage "https://github.com/CheerChen/ctxd"
  url "https://github.com/CheerChen/ctxd/archive/refs/tags/v0.4.5.tar.gz"
  sha256 "54220bc5ee83227a881bbe1bfb4f9fb404edf777d048e98b1572a936d821877c"
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
