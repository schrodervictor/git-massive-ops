#!/bin/bash

BITBUCKET_USERNAME="username"
BITBUCKET_PASSWORD="password"

copy_to_bitbucket() {

    local PROJECT="$1"
    local PREFIX="$2"
    local REPO_NAME="$3"
    local DEST_DIR="$PROJECT/$REPO_NAME"

    echo -e "\n\nStarting copy of [$PROJECT/$REPO_NAME]"
    echo "Creating the remote repo on BitBucket"
    curl --user "$BITBUCKET_USERNAME":"$BITBUCKET_PASSWORD" https://api.bitbucket.org/1.0/repositories/ --data name="$PROJECT/$REPO_NAME" --data is_private='true'
    echo "Adding bitbucket as an additional Git Remote"
    git -C "$DEST_DIR" remote add bitbucket "git@bitbucket.org:$BITBUCKET_USERNAME/${PROJECT,,}-${REPO_NAME,,}.git"
    echo "Pushing all branches to bitbucket"
    git -C "$DEST_DIR" push bitbucket --all
    echo "Pushing all tags to bitbucket"
    git -C "$DEST_DIR" push bitbucket --tags
    echo "Removing bitbucket from Git Remote"
    git -C "$DEST_DIR" remote remove bitbucket
}


while read -r PROJECT PREFIX REPO; do
    if [[ -z $PROJECT || -z $PREFIX || -z $REPO ]]; then
        continue
    fi
    copy_to_bitbucket "$PROJECT" "$PREFIX" "$REPO"
done < $1
