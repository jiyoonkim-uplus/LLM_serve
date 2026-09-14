from huggingface_hub import snapshot_download

snapshot_download(
    repo_id="Qwen/Qwen3.8-27B-FP8",  # 모델 이름
    local_dir="/data/public/model"  # 저장 경로
)
