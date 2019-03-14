class Gojo < Formula
  homepage 'https://github.com/itchyny/gojo'
  version '0.0.0'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/gojo/releases/download/v0.0.0/gojo_darwin_amd64.zip'
    sha256 '2d07f1699d5d16169c49bc6339397b89062f00030f49ea1c4361d1bf935f086e'
  else
    url 'https://github.com/itchyny/gojo/releases/download/v0.0.0/gojo_darwin_386.zip'
    sha256 '7152f8ae436e3a394b4d1f1efab3b4599ae0cc59b7b295cbcf95399a134f37fc'
  end

  head do
    url 'https://github.com/itchyny/gojo.git'
    depends_on 'go' => :build
    depends_on 'git' => :build
    depends_on 'mercurial' => :build
  end

  def install
    if build.head?
      ENV['GOPATH'] = buildpath/'.go'
      mkdir_p buildpath/'.go/src/github.com/itchyny'
      ln_s buildpath, buildpath/'.go/src/github.com/itchyny/gojo'
      system 'make', 'build'
      bin.install 'build/gojo'
    else
      bin.install 'gojo'
    end
  end

  test do
    system 'gojo', '--version'
  end
end
