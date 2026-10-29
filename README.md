# RustGIS 一键安装指南

> 第三方部署指南 · 非 RustGIS 官方仓库。官方项目：[opengeos/RustGIS](https://github.com/opengeos/RustGIS)
> 内容来自官方文档（2026-10-29）。项目迭代快，请以[官方文档](https://github.com/opengeos/RustGIS#readme)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 一个原生程序把矢量、栅格、3D 地球和出图都包了，数据留在自己机器上。

⚠️ Windows 10/11、macOS（Intel / Apple Silicon）、Linux（deb / rpm / AppImage）都有安装包，约 31–49 MB，不需要另装运行环境。界面由 GPU 绘制，老显卡或远程桌面可能降速。也有免安装网页版 web.rustgis.app，但大数据与本地文件仍建议桌面版。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/rustgis-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会按系统选安装包，下载后比对 SHA256，再引导你完成安装，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## RustGIS 是什么？

RustGIS 是开源的纯 Rust 编写、GPU 绘制的桌面 GIS，Windows、macOS、Linux 与浏览器都能用（协议：Apache-2.0，<img src="https://img.shields.io/github/stars/opengeos/RustGIS?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

原生 Rust + GPU 绘制的桌面 GIS：矢量与栅格图层、符号与标注、3D 地球与投影、布局出图、插件市场和 ModelBuilder，数据默认只在本机。

- 跨平台：Windows、macOS、Linux 同一套界面
- 免运行环境：一个安装包，不用装 Python / Java
- GPU 绘制：大图层缩放拖动更顺
- 矢量 + 栅格：GeoTIFF、COG、XYZ、WMS、矢量瓦片
- 3D 地球与投影：Equal Earth、Robinson 或任意 EPSG
- 布局出图：图框、图例、比例尺、PDF 导出
- 插件与 ModelBuilder：把工具串成流程

（来源：[官方仓库](https://github.com/opengeos/RustGIS)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 2 | . |
| 免 | 运 |
| 性 | 能 |
| 功 | 能 |
| 本 | 地 |
| A | p |

| 需要注意 | 说明 |
|---|---|
| 桌 | 面 |
| 高 | 级 |
| 网 | 页 |
| 插 | 件 |
| 项 | 目 |

> 以上基于官方文档与社区反馈整理（2026-10-29），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -o RustGIS-0.4.0-linux-x86_64.AppImage https://github.com/opengeos/RustGIS/releases/download/v0.4.0/RustGIS-0.4.0-linux-x86_64.AppImage
echo "70e80502188c39849ed015811e87f5e438df9a63cb6a1b8e64512e672b3c82fc  RustGIS-0.4.0-linux-x86_64.AppImage" | sha256sum -c -
chmod +x RustGIS-0.4.0-linux-x86_64.AppImage
echo "校验通过：运行 ./RustGIS-0.4.0-linux-x86_64.AppImage"
```

安装包来源：[https://github.com/opengeos/RustGIS/releases/latest](https://github.com/opengeos/RustGIS/releases/latest)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认三平台安装包、网页版与 GPU 绘制 | 已核对 2026-10-29 |
| Release v0.4.0 资产名、大小与 SHA256 已核对 | 已核对 2026-10-29 |
| 未实测安装与打开（会下载 31–49 MB 安装包） | 说明 2026-10-29 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-10-29 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-10-29 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不含 MCP；本仓库的 MCP 只提供安装包选择、SHA256 校验与常见问题。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-10-29）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\rustgis-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 安装包对照（v0.4.0）

| 平台 | 文件 | 大小 |
|---|---|---|
| Windows | RustGIS-0.4.0-windows-x86_64-setup.exe | 31.5 MB |
| Windows | RustGIS-0.4.0-windows-x86_64.msi | 36.6 MB |
| macOS Intel | RustGIS-0.4.0-macos-x86_64.dmg | 35.5 MB |
| macOS Apple Silicon | RustGIS-0.4.0-macos-aarch64.dmg | 32.3 MB |
| Linux x86_64 | rustgis_0.4.0_amd64.deb | 38.2 MB |
| Linux x86_64 | RustGIS-0.4.0-linux-x86_64.AppImage | 49.4 MB |
| Linux arm64 | rustgis_0.4.0_arm64.deb | 36.9 MB |

Release 里还有 `SHA256SUMS`，可以一次性核对全部文件。

## 第一次使用

1. 打开 RustGIS，加载一个 GeoJSON 或 GeoTIFF
2. 在 Style 里试符号、分级色彩与标注
3. 需要底图时再联网加载 XYZ / WMS / 矢量瓦片
4. 出图用 Layout：图框、图例、比例尺，导出 PDF
5. 重复流程用 ModelBuilder 串起来

## 注意

- 默认不联网，底图、插件、在线数据要手动触发
- 网页版功能受浏览器限制，大文件优先桌面版
- GPU 太老或远程桌面下，绘制会变慢
- 插件来自 plugins.rustgis.app，装之前看清权限

## 常见坑

- Windows 提示未知发布者：先核对 SHA256，再决定是否继续
- macOS 打不开：到系统设置里允许来自已识别开发者的应用
- Linux 缺依赖：deb 用 apt install ./文件名.deb 而不是 dpkg -i
- 界面卡顿：关闭超大图层或换本地显卡，远程桌面下更明显
- 底图不显示：检查网络与代理，底图是联网加载的
- 插件装不上：确认 RustGIS 版本与插件要求匹配

## 免责声明

本仓库为第三方指南，与 RustGIS 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-10-29），项目迭代快，请以[官方文档](https://github.com/opengeos/RustGIS#readme)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
