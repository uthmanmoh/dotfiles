#!/bin/zsh

if [ -d ~/Downloads/kotlin-language-server ]; then
  # update repo
  cd ~/Downloads/kotlin-language-server
  git pull
else
  # clone and setup repo
  git clone https://github.com/kotlin-community-tools/kotlin-language-server.git ~/Downloads/kotlin-language-server
  cd ~/Downloads/kotlin-language-server
  ./gradlew :server:installDist
fi
