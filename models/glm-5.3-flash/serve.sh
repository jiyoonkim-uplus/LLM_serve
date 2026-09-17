#!/bin/bash
# GLM 5.3 Flash vLLM Serve Script


# 다운로드 스크립트(download.py)의 local_dir 경로와 일치시켜야 합니다.
vllm serve /data/public/model/GLM-5.3-Flash \
  --host 0.0.0.0 \
  --port 8000 \
  --tensor-parallel-size 8 \
  --tool-call-parser glm47 \
  --reasoning-parser glm45 \
  --enable-auto-tool-choice \
  --served-model-name glm-5.3-flash-fp8 \
  --max-model-len 1048576 \
  --gpu-memory-utilization 0.90 \
  --enable-chunked-prefill \
  --enable-prefix-caching
