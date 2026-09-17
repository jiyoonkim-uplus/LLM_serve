#!/bin/bash
# Qwen 3.8 vLLM Serve Script

NCCL_SHM_DISABLE=1 \
vllm serve /data/public/model/Qwen-3.8-27B-FP8 \
  --host 0.0.0.0 \
  --port 8001 \
  --tensor-parallel-size 4 \
  --data-parallel-size 2 \
  --kv-cache-dtype fp8 \
  --enable-auto-tool-choice \
  --tool-call-parser qwen3_coder \
  --reasoning-parser qwen3 \
  --mm-encoder-tp-mode data \
  --max-model-len 262144 \
  --gpu-memory-utilization 0.90 \
  --served-model-name qwen-3.8-27b-fp8 \
  --enable-chunked-prefill \
  --enable-prefix-caching 
