#!/usr/bin/env bash
set -euox pipefail

# IMAGES='["aurora", "aurora-dx"]'
# IMAGE_FLAVORS='["main", "nvidia-open"]'
# STREAM_NAME='["testing"]'
# ARCHITECTURES='["amd64", "arm64"]'

echo $IMAGES

jq -cn \
  --argjson base_names "$IMAGES" \
  --argjson image_flavors "$IMAGE_FLAVORS" \
  --argjson stream_name "$STREAM_NAME" \
  --argjson stream_name "$(jq -R . <<< "$STREAM_NAME" || echo "$STREAM_NAME")" \
  --argjson architectures "$ARCHITECTURES" \
  '
  {
    include: [
      $base_names[] as $b |
      $image_flavors[] as $f |
      (if ($stream_name | type) == "array" then $stream_name[] else $stream_name end) as $s |
      $architectures[] as $a |
      {
        image_name: $b,
        image_flavor: $f,
        stream_name: $s,
        architecture: $a
      }
    ]
  }
  '

