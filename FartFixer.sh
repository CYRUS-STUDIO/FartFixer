#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <bin_dir>"
    exit 1
fi

BIN_DIR="$1"

# 查找所有 .bin 文件
find "$BIN_DIR" -type f -name "*.bin" | while read BIN_PATH; do
    BIN_FILE=$(basename "$BIN_PATH")
    PREFIX="${BIN_FILE%%_*}_"  # 提取前缀，例如 11994176_

    # 查找对应的 dex 文件
    find "$BIN_DIR" -type f -name "${PREFIX}*.dex" | while read DEX_PATH; do
        DEX_FILE=$(basename "$DEX_PATH")
        DEX_DIR=$(dirname "$DEX_PATH")

        # 创建 fix 目录
        FIX_DIR="$DEX_DIR/fix"
        mkdir -p "$FIX_DIR"

        # 构造输出路径
        FIXED_DEX="$FIX_DIR/${DEX_FILE/_file/_file_fix}"

        echo "修复 $DEX_FILE，使用 $BIN_FILE ..."
        java -jar ./FartFixer.jar "$DEX_PATH" "$BIN_PATH" "$FIXED_DEX"
    done
done