#!/bin/bash

# Usage: `bash change_env.sh $1 $2`，将用户变量$1设为$2，在运行后可能需要手动的`source .bashrc`

# 检查传入的参数数量
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 VAR_NAME VAR_VALUE"
    exit 1
fi

# 从命令行参数获取环境变量名和对应的值
VAR_NAME="$1"
VAR_VALUE="$2"

# ~/.bashrc 文件路径
BASHRC_FILE="$HOME/.bashrc"

# 确保 ~/.bashrc 文件存在
if [ ! -f "$BASHRC_FILE" ]; then
    echo "Error: $BASHRC_FILE does not exist."
    exit 1
fi

# 使用临时文件进行更新
TMP_FILE=$(mktemp)

# 检查环境变量是否已存在于 ~/.bashrc 中
if grep -q "^export $VAR_NAME=" "$BASHRC_FILE"; then
    # 如果变量已存在，则更新其值
    echo "Updating $VAR_NAME in $BASHRC_FILE"
    awk -v var="$VAR_NAME" -v val="$VAR_VALUE" '
    $0 ~ "^export " var "=" { print "export " var "=" "\"" val "\"" }
    $0 !~ "^export " var "=" { print }
    ' "$BASHRC_FILE" > "$TMP_FILE"
else
    # 如果变量不存在，则添加新变量
    echo "Adding $VAR_NAME to $BASHRC_FILE"
    cat "$BASHRC_FILE" > "$TMP_FILE"
    echo "export $VAR_NAME=\"$VAR_VALUE\"" >> "$TMP_FILE"
fi

# 替换原文件
mv "$TMP_FILE" "$BASHRC_FILE"

# 使更改立即生效
source "$BASHRC_FILE"

echo "Environment variable $VAR_NAME is now set to $VAR_VALUE"