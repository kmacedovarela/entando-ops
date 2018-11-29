#!/usr/bin/env bash
cd /tmp/
echo "ENTANDO_VERSION = $ENTANDO_VERSION"
curl -L "https://github.com/entando/entando-sample-minimal/archive/v${ENTANDO_VERSION}.zip" -o entando-sample-minimal.zip
unzip entando-sample-minimal.zip
pushd entando-sample-minimal-${ENTANDO_VERSION}
if $(dirname ${BASH_SOURCE[0]})/init-db.sh ; then
  find $HOME/.m2 -name "_remote.repositories" -type f -delete
  find $HOME/.m2 -name "*.lastUpdated" -type f -delete
  find $HOME/.m2 -name "resolver-status.properties" -type f -delete
  echo "Fixing M2 permissions ..."
  chown -Rf $USERID_TO_USE:0 ${HOME}/.m2
  chmod -Rf ug+rw ${HOME}/.m2
  ls -al ${HOME}/.m2/repository
  popd
#Keep the image lean:
  rm -Rf entando-sample-full-${ENTANDO_VERSION}
  echo "DB init succeeded"
  exit 0
else
  echo "DB init failed"
  exit 1
fi
