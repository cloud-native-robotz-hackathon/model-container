#!/usr/bin/env bash
# set -x
aws configure list

for model in $(find /model -name '*.onnx' ); do
    echo "Upload model $model"
    aws s3 --no-verify-ssl cp \
        --endpoint-url $AWS_S3_ENDPOINT \
        ${model} \
        s3://$AWS_S3_BUCKET/backup/$(basename $model)
done
