# base_images
Repo for the base docker images

## Dockerfiles

| Dockerfile | Python | CUDA | PyTorch | cuDNN | TensorRT | ONNX | Ubuntu | Notes |
|---|---|---|---|---|---|---|---|---|
| `Dockerfile_py312_cuda121_ubuntu22` | 3.12 | 12.1 | 2.3.1 | - | - | - | 22 | Base image |
| `Dockerfile_py312_cuda124_cudnn9_trt109_ubuntu22` | 3.12 | 12.4 | 2.4.1 | 9 | 10.9 | Yes  | 22 | Includes TensorRT |
| `Dockerfile_py312_cuda126_cudnn9_deploy_ubuntu24` | 3.12 | 12.6 | - | 9 | - | Yes | 24 | Deploy-oriented image |
| `Dockerfile_py312_cuda126_cudnn9_onnx_ubuntu24` | 3.12 | 12.6 | 2.8.0 | 9 | - | Yes | 24 | Includes ONNX |
| `Dockerfile_py312_cuda126_cudnn9_trt109_ubuntu24` | 3.12 | 12.6 | 2.8.0 | 9 | 10.9 | Yes  | 24 | Includes TensorRT |
| `Dockerfile_py312_cuda126_cudnn9_ubuntu24` | 3.12 | 12.6 | 2.8.0 | 9 | - | - | 24 | Base image with cuDNN |
| `Dockerfile_py312_cuda126_ubuntu24` | 3.12 | 12.6 | 2.8.0 | - | - | - | 24 | Base image |
| `Dockerfile_py312_cuda130_ubuntu24_dgxspark` | 3.12 | 13.0 | 2.10.0 | - | - | - | 24 | DGX Spark variant |


