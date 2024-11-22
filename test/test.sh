source .venv/bin/activate
unset CONDA_PREFIX
cargo build
maturin develop
python test/test.py