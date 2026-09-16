#!/bin/bash
# GLM 5.3 Flash setting environment

# cuda: 13.0
# python: 3.12.3

uv venv -p 3.12.3
source .venv/bin/activate
uv pip install -U vllm --pre \
--extra-index-url https://wheels.vllm.ai/nightly/cu130 \
--extra-index-url https://download.pytorch.org/whl/cu130 \
--index-strategy unsafe-best-match
uv pip install flashinfer-python>=0.6.17
uv pip install nixl
