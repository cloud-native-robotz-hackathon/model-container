# Model Container

## Versions

|Version|Yolo|CPU or GPU|Epoch|batch_size|Sample images|Size of the Model om MB|
|---|---|---|---|---|---|---|
|1|yolov5n|CPU|?|?|?|?|8mb|
|2|yolov5n|CPU|113|?|?|8mb|
|3|yolov5m|CPU|2|4|?|?|80mb|

## Example population

```yaml
oc create -f - <<EOF
apiVersion: batch/v1
kind: Job
metadata:
  generateName: populate-backup-model-
spec:
  template:
    spec:
      restartPolicy: Never
      containers:
      - name: upload
        imagePullPolicy: Always
        image: quay.io/cloud-native-robotz-hackathon/model-container:trained-uploader-1.25.83-20250305T155136
        envFrom:
        - secretRef:
            name: workbench-bucket-ai-connection
  backoffLimit: 4
EOF
```

## Tree

```
./model
./model/robot_onnx
./model/robot_onnx/1
./model/robot_onnx/1/model.onnx
./Containerfile
```

## Build

```bash
export VERSION=$(date +"%Y%m%dT%H%M%S")
export IMAGE="quay.io/cloud-native-robotz-hackathon/model-container:trained-uploader-1.25.83-${VERSION}"
podman manifest rm ${IMAGE}
podman build --platform linux/amd64,linux/arm64  --manifest ${IMAGE}  .
podman manifest push ${IMAGE}
```

