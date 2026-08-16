#!/usr/bin/env bash
set -euox pipefail

# IMAGES='["aurora", "aurora-dx"]'
# IMAGE_FLAVORS='["main", "nvidia-open"]'
# STREAM_NAME='["testing"]'
# ARCHITECTURES='["amd64", "arm64"]'
#
# IMAGES='["aurora", "aurora-dx"]' IMAGE_FLAVORS='["main", "nvidia-open"]' STREAM_NAME='["testing"]' ARCHITECTURES='["amd64", "arm64"]' matrix.sh

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
      $architectures[] as $a |
      {
        image_name: $b,
        image_flavor: $f,
        stream_name: $stream_name,
        architecture: $a
      }
    ]
  }
  '
