#!/bin/bash
# GLM 5.3 vLLM Serve Script


vllm serve zai-org/GLM-5.3 \   # 실제 경로로 수정 필요
  --host 0.0.0.0 \
  --port 8000 \
  --tensor-parallel-size 8 \
  --kv-cache-dtype fp8 \
  --speculative-config.method mtp \
  --speculative-config.num_speculative_tokens 5 \
  --tool-call-parser glm47 \
  --reasoning-parser glm45 \
  --enable-auto-tool-choice \
  --served-model-name glm-5.3 \
  --max-model-len 524288 \
  --gpu-memory-utilization 0.95 \
  --enable-chunked-prefill \
  --enable-prefix-caching
