#!/usr/bin/env bash
set -euo pipefail
# RustGIS 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/opengeos/RustGIS#readme
# 更新日期：2026-10-29
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fL -o RustGIS-0.4.0-linux-x86_64.AppImage https://github.com/opengeos/RustGIS/releases/download/v0.4.0/RustGIS-0.4.0-linux-x86_64.AppImage
echo "70e80502188c39849ed015811e87f5e438df9a63cb6a1b8e64512e672b3c82fc  RustGIS-0.4.0-linux-x86_64.AppImage" | sha256sum -c -
chmod +x RustGIS-0.4.0-linux-x86_64.AppImage
echo "校验通过：运行 ./RustGIS-0.4.0-linux-x86_64.AppImage"

echo ""

echo "安装完成：首次打开先加载示例图层；要底图或插件时才联网，日常编辑与出图都能离线"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/opengeos/RustGIS#readme"
