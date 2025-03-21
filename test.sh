#!/bin/bash

set -euo pipefail

maturin build
uv pip install target/wheels/hf_transfer-*.whl

uv pip install huggingface_hub

rm -rf "$HOME/.cache/huggingface/hub"

read -r -d '' SCRIPT << EOF || :
from huggingface_hub import snapshot_download
snapshot_download(repo_id="lysandre/arxiv-nlp")
EOF

export HF_HUB_ENABLE_HF_TRANSFER=1
export PGET_HF_TRANSFER=1
export PGET_METRICS_ENDPOINT=http://localhost:4900/metrics
python3 -c "$SCRIPT"
