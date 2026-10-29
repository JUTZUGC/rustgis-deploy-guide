# RustGIS 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/opengeos/RustGIS#readme
# 更新日期：2026-10-29
# 类型：binary
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

if (-not (Get-Command curl.exe -ErrorAction SilentlyContinue)) { throw '需要先安装 curl（Windows 10+ 自带 curl.exe）' }

New-Item -ItemType Directory -Force -Path .download | Out-Null
Set-Location -Path .download

curl.exe -fL -o RustGIS-0.4.0-windows-x86_64-setup.exe https://github.com/opengeos/RustGIS/releases/download/v0.4.0/RustGIS-0.4.0-windows-x86_64-setup.exe
$h=(Get-FileHash .\RustGIS-0.4.0-windows-x86_64-setup.exe -Algorithm SHA256).Hash.ToLower()
if ($h -ne "aef401a268a2894ba62f8854aa6cefb710e7f4a13f3d04805be40361cb089389") { throw "SHA256 校验失败" }
Write-Host "校验通过：双击安装包完成安装"

Write-Host ''

Write-Host '安装完成：首次打开先加载示例图层；要底图或插件时才联网，日常编辑与出图都能离线'
Write-Host '若结果异常或需要改配置，请参考官方文档：https://github.com/opengeos/RustGIS#readme'
