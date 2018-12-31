#!/usr/bin/env bash
export VERSION=${1:-5.0.3-SNAPSHOT}
#!/usr/bin/env bash
IMAGES_IN_SEQUENCE=$(cat IMAGES_IN_SEQUENCE)
for D in ${IMAGES_IN_SEQUENCE[@]}; do
    pushd $D
    echo $D
    docker pull entando/$D:$VERSION
    popd
done




