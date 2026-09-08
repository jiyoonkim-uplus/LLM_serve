#!/bin/bash
# Qwen 3.8 vLLM Serve Script


vllm serve /data/public/model/Qwen--Qwen3.8-27B \  # 실제 경로로 수정 필요
  --host 0.0.0.0 \
  --port 8001 \
  --tensor-parallel-size 8 \
  --enable-auto-tool-choice \
  --tool-call-parser qwen3_coder \
  --reasoning-parser qwen3 \
  --mm-encoder-tp-mode data \
  --max-model-len 262144 \
  --gpu-memory-utilization 0.90 \
  --served-model-name qwen-3.8-27b \
  --speculative-config '{"method":"mtp","num_speculative_tokens":3}'
