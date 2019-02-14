require 'formula'

class Springboot < Formula
  homepage 'https://spring.io/projects/spring-boot'
  url 'https://github.com/fifman/spring-boot/blob/master/spring-boot-project/spring-boot-cli/release/spring-boot-cli-2.2.0.BUILD-SNAPSHOT-bin.tar.gz'
  version '2.2.0.BUILD-SNAPSHOT'
  sha256 '2d02229a4a083b98452c31e8563f2b29d55c628d65694f21bc26c365a9e63a75'
  head 'https://github.com/fifman/spring-boot.git'

  if build.head?
    depends_on 'maven' => :build
  end

  def install
    if build.head?
      Dir.chdir('spring-boot-projects/spring-boot-cli') { system 'mvn -U -DskipTests=true package' }
      root = 'spring-boot-projects/spring-boot-cli/target/spring-boot-cli-*-bin/spring-*'
    else
      root = '.'
    end

    bin.install Dir["#{root}/bin/spring"]
    lib.install Dir["#{root}/lib/spring-boot-cli-*.jar"]
    bash_completion.install Dir["#{root}/shell-completion/bash/spring"]
    zsh_completion.install Dir["#{root}/shell-completion/zsh/_spring"]
  end
end
