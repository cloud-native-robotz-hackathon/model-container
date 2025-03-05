FROM quay.io/cloud-native-robotz-hackathon/ubi-awscli:1.25.83

ADD upload.sh /
ADD model /model

USER 0
RUN chmod -R g+rwx /model

ENTRYPOINT "/upload.sh"