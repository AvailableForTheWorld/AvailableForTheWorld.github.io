#!/bin/bash

# Get the latest tag
latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "0.0.0")

# Split the tag into an array
IFS='.' read -ra VERSION <<< "$latest_tag"

# Increment the patch version (last number)
((VERSION[2]++))

# Create new tag string
new_tag="${VERSION[0]}.${VERSION[1]}.${VERSION[2]}"

# Create commit message from changelog
commit_msg=$(grep -A 5 "### \[$new_tag\]" README.md | tail -n +2)

if [ -z "$commit_msg" ]; then
    echo "Error: No changelog entry found for version $new_tag"
    exit 1
fi

# Create and push the new tag
git tag -a "$new_tag" -m "$commit_msg"
git push origin "$new_tag"

echo "Created and pushed tag: $new_tag"