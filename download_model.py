from huggingface_hub import snapshot_download

snapshot_download(
    repo_id="zai-org/GLM-5.2-FP8",  # 모델 이름
    local_dir="/data/public/model"  # 저장 경로
)
