class Gitact < Formula
  desc "Modern interactive CLI for exploring GitHub profiles, repositories, and activity"
  homepage "https://github.com/nathbns/gitact"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/nathbns/gitact/releases/download/v#{version}/gitact-#{version}-darwin-amd64.tar.gz"
      sha256 "061957366fac68763d4ace8b2e3e536fec62fbb6bc61e27eb534d2795c857f42"
    else
      url "https://github.com/nathbns/gitact/releases/download/v#{version}/gitact-#{version}-darwin-arm64.tar.gz"
      sha256 "3f9fedfa727fc6a71c8e7faab0176698f0351bfe09cb878d1d36387711aabc71"
    end
  end



  def install
    bin.install "gitact"

    # Install shell completions if available
    if File.exist?("completions/gitact.bash")
      bash_completion.install "completions/gitact.bash"
    end
    if File.exist?("completions/gitact.zsh")
      zsh_completion.install "completions/gitact.zsh"
    end
    if File.exist?("completions/gitact.fish")
      fish_completion.install "completions/gitact.fish"
    end

    # Install man page if available
    if File.exist?("man/gitact.1")
      man1.install "man/gitact.1"
    end
  end

  test do
    # Test that the binary exists and shows version
    assert_match version.to_s, shell_output("#{bin}/gitact --version")

    # Test help command
    assert_match "GitHub Activity CLI", shell_output("#{bin}/gitact --help")

    # Test that it handles invalid arguments gracefully
    assert_match "Usage:", shell_output("#{bin}/gitact 2>&1", 1)
  end

  def caveats
    <<~EOS
      🐙 GitHub Activity CLI installed successfully!

      🔑 For the best experience, set up a GitHub token:
         export GITHUB_TOKEN=your_token_here

      📖 Quick start:
         gitact karpathy          # Interactive dashboard
         gitact --repos torvalds  # Repository listing
         gitact --help           # Show all options

      💡 Rate limits:
         • Without token: 60 requests/hour
         • With token: 5,000 requests/hour

      🎯 Create a token at: https://github.com/settings/tokens
         Required scope: public_repo
    EOS
  end
end
