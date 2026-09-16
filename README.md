# LLM Serve

다양한 LLM(Large Language Model)의 환경설정 및 vLLM 기반 서빙을 위한 통합 프로젝트입니다. 모델별로 독립된 설정과 의존성을 관리하여 확장 가능한 구조를 제공합니다.

## 📂 디렉토리 구성

```text
LLM_serve/
├── main.sh                # 모델 선택 및 실행을 위한 통합 진입점
├── models/                # 모델별 설정 및 스크립트 저장소
│   ├── glm-5.3-flash/     # GLM-5.3 Flash 전용 설정
│   │   ├── download.py    # 모델 다운로드 스크립트
│   │   ├── install_docker.sh # Docker 이미지 pull (권장 설치 방식)
│   │   ├── install.sh     # 참고용: 수동 설치 스크립트
│   │   ├── requirements.txt # 참고용: 모델 전용 의존성
│   │   └── serve.sh       # vLLM 서빙 실행 스크립트
│   └── qwen-3.8-27b-fp8/  # Qwen-3.8 27B FP8 전용 설정
│       ├── download.py
│       ├── serve.sh
│       └── requirements.txt
├── curl_test.sh           # 서빙 서버 테스트용 curl 스크립트
└── README.md              # 프로젝트 문서
```

## ⚙️ 사전 요구 사항

- Python 3.12+
- NVIDIA GPU 환경 (모델별 `tensor-parallel-size` 확인 필요)
- (선택) HuggingFace 액세스 토큰 — gated 모델 다운로드 시 필요 (`huggingface-cli login`)

## 🚀 사용 방법

모든 작업은 루트 디렉토리의 `main.sh`를 통해 수행합니다.

### 1. 환경 구축 (의존성 설치)
모델마다 요구하는 라이브러리 버전이 다를 수 있으므로, 먼저 해당 모델의 의존성을 설치합니다.

**GLM-5.3 Flash는 Docker 설치를 권장합니다.**
```bash
bash models/glm-5.3-flash/install_docker.sh
# vllm/vllm-openai:glm53-flash 이미지를 pull 합니다.
```

Docker를 사용하지 않는 경우(수동 설치):
```bash
./main.sh install [model_name]
# 예: ./main.sh install glm-5.3-flash
```
> 참고: `models/glm-5.3-flash/`의 `install.sh`와 `requirements.txt`는 수동 설치용 참고 자료입니다. pip 의존성 충돌이 발생하기 쉬워 Docker 설치를 권장합니다.

### 2. 모델 다운로드
모델을 로컬 경로에 다운로드합니다.
```bash
./main.sh download [model_name]
# 예: ./main.sh download glm-5.3-flash
```

### 3. vLLM 서빙 실행
OpenAI 호환 API 서버를 구동합니다.
```bash
./main.sh serve [model_name]
# 예: ./main.sh serve glm-5.3-flash
```

## 🧪 서버 테스트

서버가 정상 구동된 후 `curl_test.sh`를 통해 응답을 확인합니다.

```bash
bash curl_test.sh
```

### 요청 예시 (GLM-5.3)
```bash
curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "glm-5.3-flash",
    "messages": [{"role": "user", "content": "모델에 대해 설명해줘."}],
    "temperature": 1,
    "max_tokens": 4096,
    "chat_template_kwargs": {"reasoning_effort": "high"}
  }'
```

- `reasoning_effort`: `high` / `medium` / `low`로 조정하여 추론(Thinking) 정도를 제어할 수 있습니다.
