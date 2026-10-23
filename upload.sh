#!/usr/bin/env bash
# set -x
aws configure list

ADD model/yolov5n-custom-images-1.onnx /models/backup-custom-images/1/model.onnx
ADD model/openimages-optimal-epochs.onnx /models/backup-open-images/1/model.onnx


echo "Upload model /model/yolov5n-custom-images-1.onnx -> s3:/models/backup-custom-images/1/model.onnx"
aws s3 --no-verify-ssl cp \
    --endpoint-url $AWS_S3_ENDPOINT \
    /model/yolov5n-custom-images-1.onnx \
    s3://$AWS_S3_BUCKET/models/backup-custom-images/1/model.onnx

echo "Upload model model/openimages-optimal-epochs.onnx -> s3:/models/backup-open-images/1/model.onnx"
aws s3 --no-verify-ssl cp \
    --endpoint-url $AWS_S3_ENDPOINT \
    /model/openimages-optimal-epochs.onnx \
    s3://$AWS_S3_BUCKET/models/backup-open-images/1/model.onnx

