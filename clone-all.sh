#!/bin/bash

REPO_BASE_URL="ssh://git@stash.your-company.com:7999/"

clone_repo() {

    local PROJECT="$1"
    local PREFIX="$2"
    local REPO_NAME="$3"
    local DEST_DIR="$PROJECT/$REPO_NAME"

    echo "Creating the folder to clone in: $DEST_DIR"
    mkdir -p "$DEST_DIR"

    echo "Cloning the repo: $DEST_DIR"

    git clone "$REPO_BASE_URL$PREFIX/$REPO_NAME.git" "$DEST_DIR"

    echo "Setting all branches to track their respective remotes"

    for BRANCH in $(git -C "$DEST_DIR" branch -r | grep -v -- '->'); do
        git -C "$DEST_DIR" branch --track "${BRANCH##origin/}" "$BRANCH";
    done

    echo "Pulling all branches and tags"
    git -C "$DEST_DIR" pull --all
    git -C "$DEST_DIR" pull --tags
}


while read -r PROJECT PREFIX REPO; do
    if [[ -z $PROJECT || -z $PREFIX || -z $REPO ]]; then
        continue
    fi
    clone_repo "$PROJECT" "$PREFIX" "$REPO"
done < $1
