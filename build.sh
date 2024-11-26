#!/bin/bash
set -e

# 检查 Python 是否安装
command -v python >/dev/null 2>&1 || { echo "Python is not installed. Exiting." >&2; exit 1; }

# 检查并创建虚拟环境
if [ -d ".venv" ]; then
  echo 'Using existing virtual environment'
else
  echo 'Creating virtual environment'
  python -m venv .venv
fi

# 激活虚拟环境
source .venv/bin/activate
# 清除 CONDA_PREFIX 环境变量
unset CONDA_PREFIX

# 运行 cargo fix 和 cargo fmt
echo 'Running cargo fix...'
#cargo fix

echo 'Running cargo fmt...'
cargo fmt
if [ $? -ne 0 ]; then
    echo "Code formatting issues found. Please run 'cargo fmt' to fix them."
    exit 1
fi

# 构建 Rust 项目和安装 Python 扩展
cargo build "$@"
maturin develop "$@"
maturin build "$@"