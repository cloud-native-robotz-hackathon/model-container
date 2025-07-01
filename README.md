# Model Container

## Versions

| Model                           | Yolo     | CPU or GPU | Epoch | batch_size | Sample images | Size of the Model in MB |
| ------------------------------- | -------- | ---------- | ----- | ---------- | ------------- | ----------------------- |
|`yolov5n-1.onnx`                 | yolov5n  | CPU        | ?     | ?          | ?             | 8                       |
|`yolov5n-2.onnx`                 | yolov5n  | CPU        | 113   | ?          | ?             | 8                       |
|`yolov5m-1.onnx`                 | yolov5m  | CPU        | 2     | 4          | ?             | 80                      | 
|`yolov5n-custom-images-1.onnx`   | yolov5n  | CPU        | 300   | 64         | 100           | 7.5                     |
|`openimages-optimal-epochs.onnx` | yolov5n  | GPU        | 162   | 64         | 10000         | 7.1                     |

## Example population

```yaml
export IMAGE="quay.io/cloud-native-robotz-hackathon/model-container:trained-uploader-1.25.83-20250515T125636"
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
        image: ${IMAGE}
        envFrom:
        - secretRef:
            name: workbench-bucket-ai-connection
  backoffLimit: 4
EOF
```

## Build

```bash
export VERSION=$(date +"%Y%m%dT%H%M%S")
export IMAGE="quay.io/cloud-native-robotz-hackathon/model-container:trained-uploader-1.25.83-${VERSION}"
podman manifest rm ${IMAGE}
podman build --platform linux/amd64,linux/arm64  --manifest ${IMAGE}  .
podman manifest push ${IMAGE}
```

### Online image

```bash
export VERSION=$(date +"%Y%m%dT%H%M%S")
export IMAGE="quay.io/cloud-native-robotz-hackathon/model-container:trained-uploader-1.25.83-online-${VERSION}"
podman manifest rm ${IMAGE}
podman build --platform linux/amd64,linux/arm64 \
  -f online-downloader-Containerfile \
  --manifest ${IMAGE} .
podman manifest push ${IMAGE}
```
