#!/bin/sh

# mozjpeg
echo "MOZJPEG_PATH = '/usr/local/bin/mozjpeg'" >> /usr/local/thumbor/thumbor.conf
echo "MOZJPEG_QUALITY = 80" >> /usr/local/thumbor/thumbor.conf

# pngquant
echo "PNGQUANT_PATH = '/usr/bin/pngquant'" >> /usr/local/thumbor/thumbor.conf
echo "PNGQUANT_SPEED = 3" >> /usr/local/thumbor/thumbor.conf

# set OPTIMIZERS
echo "OPTIMIZERS = ['thumbor_plugins.optimizers.mozjpeg', 'thumbor_plugins.optimizers.pngquant']" >> /usr/local/thumbor/thumbor.conf

# configure gcs
GCS=$(cat <<EOF
################################# Thumbor Config ##################################

## Thumbor engine to use.
ENGINE = '{{ ENGINE | default('thumbor.engines.pil')}}'

################################# GCS Storage ##################################

## GCS Bucket where thumbor's loader will fetch images from.
LOADER = '{{ LOADER | default('thumbor_gcs.loader.gcs_loader')}}'

## GCS Bucket ID where thumbor's loader will fetch images from.
LOADER_GCS_BUCKET_ID = '{{ LOADER_GCS_BUCKET_ID | default('') }}'

## GCS Project ID where thumbor's loader will fetch images from.
LOADER_GCS_PROJECT_ID = '{{ LOADER_GCS_PROJECT_ID | default('') }}'

## GCS Root Path where thumbor's loader will fetch images from.
LOADER_GCS_ROOT_PATH = '{{ LOADER_GCS_ROOT_PATH | default('') }}'

## GCS Bucket ID where thumbor's result storage will store images.
RESULT_STORAGE = '{{ RESULT_STORAGE | default('thumbor_gcs.result_storage.gcs_result_storage')}}'

## GCS Bucket ID where thumbor's result storage will store images.
RESULT_STORAGE_GCS_BUCKET_ID = '{{ RESULT_STORAGE_GCS_BUCKET_ID | default('') }}'

## GCS Project ID where thumbor's result storage will store images.
RESULT_STORAGE_GCS_PROJECT_ID = '{{ RESULT_STORAGE_GCS_PROJECT_ID | default('') }}'

## GCS Root Path where thumbor's result storage will store images.
RESULT_STORAGE_GCS_ROOT_PATH = '{{ RESULT_STORAGE_GCS_ROOT_PATH | default('') }}'

################################################################################

EOF
)

echo -e "$GCS" | envtpl >> /usr/local/thumbor/thumbor.conf