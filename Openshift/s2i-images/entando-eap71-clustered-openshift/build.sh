#!/usr/bin/env bash
export VERSION=${1:-5.0.2-SNAPSHOT}
export ENTANDO_IMAGE="entando-eap71-clustered-openshift"
source ../../../common/build-common.sh