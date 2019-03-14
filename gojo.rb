class Gojo < Formula
  homepage 'https://github.com/itchyny/gojo'
  version '0.0.1'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/gojo/releases/download/v0.0.1/gojo_darwin_amd64.zip'
    sha256 '6f78dc62aeb6a3597ce98c2039e0e3bcd9504b777b11ac73513a115d899b6121'
  else
    url 'https://github.com/itchyny/gojo/releases/download/v0.0.1/gojo_darwin_386.zip'
    sha256 '03808c8ad19e0b027eb4763a363505ea4dc9c16d275b5e82f38927bd2936114d'
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
