#!/bin/bash

# 사용법: ./main.sh [download|install|serve] [model_name]
# 예: ./main.sh serve glm-5.3-flash

ACTION=$1
MODEL=$2

if [[ -z "$ACTION" || -z "$MODEL" ]]; then
    echo "Usage: ./main.sh [download|install|serve] [model_name]"
    echo "Available models: glm-5.3-flash, qwen-3.8-27b-fp8"
    exit 1
fi

MODEL_DIR="models/${MODEL}"

if [[ ! -d "$MODEL_DIR" ]]; then
    echo "Error: Model directory ${MODEL_DIR} does not exist."
    exit 1
fi

if [[ "$ACTION" == "download" ]]; then
    echo "Downloading ${MODEL}..."
    python3 "${MODEL_DIR}/download.py"
elif [[ "$ACTION" == "install" ]]; then
    echo "Installing dependencies for ${MODEL}..."
    pip install -r "${MODEL_DIR}/requirements.txt"
elif [[ "$ACTION" == "serve" ]]; then
    echo "Serving ${MODEL}..."
    bash "${MODEL_DIR}/serve.sh"
else
    echo "Invalid action: ${ACTION}. Use 'download', 'install', or 'serve'."
    exit 1
fi
