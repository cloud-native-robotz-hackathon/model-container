#!/usr/bin/env bash
set -x
aws configure list

for version in $(seq 1 2); do
    echo "Upload model v$version"
    aws s3 --no-verify-ssl cp \
        --endpoint-url $AWS_S3_ENDPOINT \
        /model/robot_onnx/${version}/model.onnx \
        s3://$AWS_S3_BUCKET/backup/model-v${version}.onnx

done
