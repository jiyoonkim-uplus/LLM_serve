# GLM_serve

[zai-org/GLM-5.2-FP8](https://huggingface.co/zai-org/GLM-5.2-FP8) 모델의 환경설정 및 vLLM 기반 서빙을 위한 프로젝트입니다.

## 디렉토리 구성

```
GLM_serve/
├── README.md            # 프로젝트 문서
├── requirements.txt     # Python 의존성
├── download_model.py    # HuggingFace 모델 다운로드 스크립트
├── vllm_serve.sh        # vLLM 서빙 실행 스크립트
└── curl_test.sh         # 서빙 서버 테스트용 curl 스크립트
```

## 사전 요구 사항

- Python 3.10+
- vLLM 0.23.0
- 다중 GPU 환경 (서빙 스크립트는 `tensor-parallel-size 8` 기준)
- (선택) HuggingFace 액세스 토큰 — 모델이 gated인 경우 필요

## 설치

```bash
pip install -r requirements.txt
```

## 1. 모델 다운로드

`download_model.py`를 실행하여 모델을 로컬 경로에 다운로드합니다.

```bash
python download_model.py
```

- 다운로드 대상: `zai-org/GLM-5.2-FP8`
- 저장 경로: `/data/public/model`

> 모델이 gated인 경우 다운로드 전에 로그인이 필요합니다.
> ```bash
> huggingface-cli login
> ```

## 2. vLLM 서빙 실행

`vllm_serve.sh`를 실행하여 OpenAI 호환 API 서버를 구동합니다.

```bash
bash vllm_serve.sh
```

### 주요 서빙 옵션

| 옵션 | 값 | 설명 |
| --- | --- | --- |
| `--host` / `--port` | `0.0.0.0` / `8000` | 서버 바인딩 주소 |
| `--tensor-parallel-size` | `8` | 텐서 병렬 GPU 수 |
| `--kv-cache-dtype` | `fp8` | KV 캐시 FP8 양자화 |
| `--speculative-config` | `mtp`, 토큰 `5` | MTP 기반 speculative decoding |
| `--tool-call-parser` | `glm47` | 도구 호출 파서 |
| `--reasoning-parser` | `glm45` | 추론 파서 |
| `--enable-auto-tool-choice` | - | 자동 도구 선택 활성화 |
| `--served-model-name` | `glm-5.2-fp8` | API에서 사용할 모델명 |
| `--max-model-len` | `524288` | 최대 컨텍스트 길이 |
| `--gpu-memory-utilization` | `0.95` | GPU 메모리 사용률 |
| `--enable-chunked-prefill` | - | 청크 단위 프리필 |
| `--enable-prefix-caching` | - | 프리픽스 캐싱 |

> **참고:** 서빙 스크립트는 모델 경로로 `zai-org/GLM-5.2-FP8`을 사용합니다.
> 1단계에서 다운로드한 로컬 경로(`/data/public/model`)를 사용하려면 `vllm_serve.sh`의 모델 경로를 해당 경로로 변경하세요.

## 3. 서버 테스트

서버가 정상 구동된 후 `curl_test.sh`로 응답을 확인합니다.

```bash
bash curl_test.sh
```

요청 예시:

```bash
curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "glm-5.2-fp8",
    "messages": [{"role": "user", "content": "GLM-5.2 모델에 대해 설명해줘."}],
    "temperature": 1,
    "max_tokens": 4096,
    "chat_template_kwargs": {"reasoning_effort": "high"}
  }'
```

`reasoning_effort`는 `high` / `medium` / `low`로 조정할 수 있으며, 추론(Thinking) 정도를 제어합니다.
