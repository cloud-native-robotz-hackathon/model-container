FROM quay.io/cloud-native-robotz-hackathon/ubi-awscli:1.25.83

ADD upload.sh /
ADD model/yolov5n-custom-images-1.onnx /model/model-custom-images.onnx
ADD model/openimages-optimal-epochs.onnx /model/model-openimages.onnx

USER 0
RUN chmod -R g+rwx /model

ENTRYPOINT "/upload.sh"