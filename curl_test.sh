curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "glm-5.2-fp8",
    "messages": [{"role": "user", "content": "GLM-5.2 모델에 대해 설명해줘."}],
    "temperature": 1,
    "max_tokens": 4096,
    "chat_template_kwargs": {"reasoning_effort": "high"}
  }'
