FROM quay.io/cloud-native-robotz-hackathon/ubi-awscli:1.25.83

ADD upload.sh /
# <prefix>/<version>/model.onnx
ADD model/yolov5n-custom-images-1.onnx /model/
ADD model/openimages-optimal-epochs.onnx /model/

USER 0
RUN chmod -R g+rwx /model
RUN chmod +rx /upload.sh

ENTRYPOINT "/upload.sh"