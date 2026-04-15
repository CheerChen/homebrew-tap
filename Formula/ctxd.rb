class Ctxd < Formula
  desc "Unified context dumper for LLM — GitHub PR, Slack, Confluence, Jira"
  homepage "https://github.com/CheerChen/ctxd"
  url "https://github.com/CheerChen/ctxd/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "3233528cb4fcd51ec655e03cd340b438a2a535471be37a36b3fe9a0d1dfbb93b"
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
