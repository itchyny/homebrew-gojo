class Gojo < Formula
  homepage 'https://github.com/itchyny/gojo'
  version '0.0.3'

  if Hardware::CPU.is_64_bit?
    url 'https://github.com/itchyny/gojo/releases/download/v0.0.3/gojo_darwin_amd64.zip'
    sha256 '402e604b660839f3234af62f4ac0423c7efeb220d2badd359fd7064c5e852bb4'
  else
    url 'https://github.com/itchyny/gojo/releases/download/v0.0.3/gojo_darwin_386.zip'
    sha256 'd05f27a273034bd285dbe9957666b5fcefcfcffad69305d468f7fb11327ff84f'
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
