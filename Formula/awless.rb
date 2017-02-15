class Awless < Formula
  desc "The Mighty CLI for AWS"
  homepage "https://github.com/wallix/awless"
  url "https://github.com/wallix/awless.git",
        :tag => "0.0.12",
        :revision => "fc49542ccd59b89347c6ac0802524f68d55c1c3b"
  head "https://github.com/wallix/awless.git"

  depends_on "go" => :build
  
  bottle do
    root_url "https://github.com/wallix/homebrew-awless/releases/download/0.0.12/"
    cellar :any_skip_relocation
    sha256 "b57ebf0c0374cd9fdc7486956d6f5bf0a932a36e91c3d4bd2ee4fd09d021b763" => :sierra
  end

  def install
    ENV["GOPATH"] = buildpath
    arch = MacOS.prefer_64_bit? ? "amd64" : "x86"
    dir = buildpath/"src/github.com/wallix/awless"
    dir.install buildpath.children - [buildpath/".brew_home"]

    cd dir do
      # Make binary
      system "go", "run", "release.go", "-tag","0.0.12","-brew","-arch","#{arch}", "-os","darwin"
      bin.install "awless"

      # Install bash completion
      output = Utils.popen_read("#{bin}/awless completion bash")
      (bash_completion/"awless").write output
      
      # Install zsh completion
      output = Utils.popen_read("#{bin}/awless completion zsh")
      (zsh_completion/"_awless").write output
    end
  end
  
  def caveats
      <<-EOS.undent
      
      In order to get awless completion, 
        [bash] you need to install `bash-completion` with brew.
        OR
        [zsh], add the following line to your ~/.zshrc:
          source #{HOMEBREW_PREFIX}/share/zsh/site-functions/_awless
      EOS
  end

  test do
    run_output = shell_output("#{bin}/awless --help 2>&1")
    assert_match "Awless is a powerful command line tool to inspect, sync and manage your infrastructure", run_output
  end
end
