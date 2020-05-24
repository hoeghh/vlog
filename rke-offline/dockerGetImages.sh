#!/bin/sh

SECONDS=0

# eg. v1.17.2-rancher1-1
VERSION=$1
REGISTRY=""

check_dependencies() {
  # The right side of && will only be evaluated if the exit status of the left side is zero (i.e. true). 
  # || is the opposite: it will evaluate the right side only if the left side exit status is non-zero (i.e. false).
  type rke >/dev/null 2>&1 || { 
    echo >&2 "I require rke but it's not installed.  Aborting."; exit 1; 
  }
  type docker >/dev/null 2>&1 || {
    echo >&2 "Docker is not installed. Aborting."; exit 1;
  }
}

check_rke_version(){
  rke config --system-images --all | grep $VERSION &> /dev/null || {
     echo "The supplied version is not supported by this releaese of RKE.  Aborting."  | tee -a output/$VERSION/log.txt; exit 1;
  }
}

clean() {
    local a=${1//[^[:alnum:]]/}
    echo "${a,,}"
}

check_dependencies

if [ -z "$VERSION" ]
then
  VERSION=$(rke config -l) 

  mkdir -p output/$VERSION

  echo " - Version is empty, using default version $VERSION
  - To get a list of supported version, run 
    - rke config --system-images --all | grep \"info\" | cut -d\"[\" -f2 | cut -d\"]\" -f1 | sort
  - Current supported versions :" | tee output/$VERSION/log.txt

  VERSION_LIST=$(rke config --system-images --all | grep "info" | cut -d"[" -f2 | cut -d"]" -f1 | sort)

  while IFS= read -r line; do
    echo "    - $line" | tee -a output/$VERSION/log.txt
  done <<< "$VERSION_LIST"

  echo "  - To specify a version to be used, run ./getImages [VERSION]
" | tee -a output/$VERSION/log.txt
else
  mkdir -p output/$VERSION
  check_rke_version
  echo " - Downloading version $VERSION" | tee output/$VERSION/log.txt
fi

LIST=$(rke --quiet config --system-images --version $VERSION)
PULL_PIDS=""

echo " - Fetching list of images on version $VERSION"  | tee -a output/$VERSION/log.txt

while IFS= read -r line; do
    echo "   - Pulling image $line"  | tee -a output/$VERSION/log.txt
    docker pull $REGISTRY$line >> output/$VERSION/log.txt &
    pids+=" $!"
done <<< "$LIST"

echo -e "
 - Waiting for all images to be done pulling \c" | tee -a output/$VERSION/log.txt

for p in $pids; do
        if wait $p; then
                echo -e "#\c" | tee -a output/$VERSION/log.txt
        else
                echo "- Process $p fail" | tee -a output/$VERSION/log.txt
                exit 1
        fi
done
echo "
   - All images are pulled. 

 - Now starting to save images to folder" | tee -a output/$VERSION/log.txt


while IFS= read -r line; do
    FILENAME="output/$VERSION/$(clean $line).tar"
    echo "   - Saving $REGISTRY$line to $FILENAME" | tee -a output/$VERSION/log.txt
    docker save $line > $FILENAME
done <<< "$LIST"

echo "
 - Done fetching RKE system images for version $VERSION
" | tee -a output/$VERSION/log.txt
echo " - Generated with "$(rke -v) | tee -a output/$VERSION/log.txt
echo " - Elapsed: $(($SECONDS / 3600))hrs $((($SECONDS / 60) % 60))min $(($SECONDS % 60))sec" | tee -a output/$VERSION/log.txt
