#!/bin/bash

# 检查参数个数
if [ $# -ne 2 ]; then
    echo "用法: 拖入 dex 文件 和 bin 文件（或通过命令行传参）"
    echo "示例: ./fartfixer.sh path/to/classes.dex path/to/libfart.so"
    exit 1
fi

DEX_PATH="$1"
BIN_PATH="$2"

# 获取目录、文件名和输出路径
FILE_DIR=$(dirname "$DEX_PATH")
FILE_BASE=$(basename "$DEX_PATH")
FILE_NAME="${FILE_BASE%.*}"
OUT_PATH="$FILE_DIR/${FILE_NAME}_fix.dex"

# 执行修复命令
java -jar "$(dirname "$0")/FartFixer.jar" "$DEX_PATH" "$BIN_PATH" "$OUT_PATH"

echo
echo "修复完成，输出文件: $OUT_PATH"