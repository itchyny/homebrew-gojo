class Gojo < Formula
  homepage 'https://github.com/itchyny/gojo'
  version '0.0.2'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/gojo/releases/download/v0.0.2/gojo_darwin_amd64.zip'
    sha256 '3f74ae39de5c0ae039e6dba35ab3f5f6165b96ed5dd5dee349380b57a75f1804'
  else
    url 'https://github.com/itchyny/gojo/releases/download/v0.0.2/gojo_darwin_386.zip'
    sha256 '5d1f86c750ad172dc0dc780f772431479b81e68fb1821d99b51c1712a8665035'
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
    system 'gojo', '-v'
  end
end
