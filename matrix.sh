#!/usr/bin/env bash
set -euox pipefail

# IMAGS='["aurora", "aurora-dx"]'
# IMAGE_FLAVORS='["main", "nvidia-open"]'
# STREAM_NAME="testing"
# ARCHITECTURES='["amd64", "arm64"]'
#
# IMAGES='["aurora", "aurora-dx"]' IMAGE_FLAVORS='["main", "nvidia-open"]' STREAM_NAME="testing" ARCHITECTURES='["amd64", "arm64"]' matrix.sh

# This is for github actions to dynamically generate the following images
# aurora aurora-dx aurora-nvidia-open aurora-dx-nvidia-open
# They each consist of 2 images, arm64 and amd64, each group is independent from the others


jq -cn \
  --argjson base_names "$IMAGES" \
  --argjson image_flavors "$IMAGE_FLAVORS" \
  --arg stream_name "$STREAM_NAME" \
  --argjson architectures "$ARCHITECTURES" \
  '
  {
    include: [
      $base_names[] as $b |
      $image_flavors[] as $f |
      {
        group: (if $f == "main" then $b else "\($b)-\($f)" end),
        image_name: $b,
        image_flavor: $f,
        stream_name: $stream_name,
        architectures: $architectures
      }
    ]
  }
  '
