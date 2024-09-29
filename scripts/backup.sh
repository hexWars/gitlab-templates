#!/bin/bash

# Usage: 输入`bash backup.sh`，并输入同级目录下的文件夹即可

# 定义颜色
ORANGE='\033[0;33m'  # 接近橙色
LIGHT_GREEN='\033[0;92m'  # 浅绿色
NC='\033[0m' # No Color

# 获取当前日期和时间
current_datetime=$(date +"%Y-%m-%d__%H-%M")

# 定义文件夹和压缩文件名
echo -e "${ORANGE}请输入./中的文件夹名: ${NC}"
read folder_name
archive_name="${folder_name}-${current_datetime}.tar.gz"

# 打包文件夹
tar -czvf "${archive_name}" "${folder_name}"

# 打印成功信息
echo -e "${LIGHT_GREEN}文件夹 ${folder_name} 已经打包成 ${archive_name}${NC}"