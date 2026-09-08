curl http://localhost:8000/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "glm-5.3",
    "messages": [{"role": "user", "content": "GLM-5.3 모델에 대해 설명해줘."}],
    "temperature": 1,
    "max_tokens": 4096,
    "chat_template_kwargs": {"reasoning_effort": "high"}
  }'
