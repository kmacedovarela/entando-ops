#!/usr/bin/env bash
cd /tmp/
echo "ENTANDO_VERSION = $ENTANDO_VERSION"
BRANCH=${ENTANDO_VERSION%-*}
if [[ "$ENTANDO_VERSION" = *"-SNAPSHOT" ]]; then
#use bnranch
    BRANCH="${BRANCH}-dev"
else
#use tag
    BRANCH="${BRANCH}"
fi
echo "BRANCH = $BRANCH"

curl -L "https://github.com/entando/entando-sample-full/archive/v${BRANCH}.zip" -o entando-sample-full.zip
unzip entando-sample-full.zip
pushd entando-sample-full-${BRANCH}
if mvn clean package --settings $HOME/.m2/settings.xml -Dproject.build.sourceEncoding=UTF-8 -Dmaven.repo.local=$HOME/.m2/repository ; then
  find $HOME/.m2 -name "_remote.repositories" -type f -delete
  find $HOME/.m2 -name "*.lastUpdated" -type f -delete
  find $HOME/.m2 -name "resolver-status.properties" -type f -delete
  echo "Fixing M2 permissions ..."
  chown -Rf $USERID_TO_USE:0 ${HOME}/.m2
  chmod -Rf ug+rw ${HOME}/.m2
  ls -al ${HOME}/.m2/repository
  popd
#Keep the image lean:
  rm -Rf entando-sample-full-${BRANCH}
  echo "Dependency init succeeded"
  exit 0
else
  echo "Dependency init failed"
  exit 1
fi