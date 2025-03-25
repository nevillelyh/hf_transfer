#!/bin/bash

set -euo pipefail

read -r -d '' SCRIPT << EOF || :
yum install openssl-devel devtoolset-10-libatomic-devel perl-IPC-Cmd -y
maturin build --release --out dist
maturin build --release --out dist -i python3.13t
EOF

docker run -t --rm -v $PWD:/io --entrypoint /bin/bash ghcr.io/pyo3/maturin -c "$SCRIPT"
