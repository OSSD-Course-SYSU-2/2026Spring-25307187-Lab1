**多端构建说明（phone + pad + tablet + 2in1）**

本说明配合仓库中的 `build-profile.phone.json5`、`build-profile.pad.json5`、`build-profile.tablet.json5` 与 `build-profile.2in1.json5` 使用，脚本位于 `scripts/`。

用法：在 Windows 上可运行 `scripts\\build-multi.bat`，在 PowerShell 上可运行 `scripts\\build-multi.ps1`。

脚本会：
- 备份当前 `build-profile.json5`（第一次运行时创建 `build-profile.backup.json5`）
- 依次将 `build-profile.phone.json5`、`build-profile.pad.json5`、`build-profile.tablet.json5` 与 `build-profile.2in1.json5` 覆盖 `build-profile.json5`，并尝试调用 `hvigor`（若 `hvigor` 在 PATH 或由 DevEco Studio 提供）
- 完成后恢复原始 `build-profile.json5`

注意事项：
- 脚本不会修改源码或 UI 文件——仅替换构建配置以实现一次开发，多端构建输出。
- 如果你的构建流程由 IDE（如 DevEco Studio）管理，脚本仍会替换配置文件，随后你可以在 IDE 中触发构建。

## 多端部署功能

本项目已配置支持鸿蒙系统的一次开发多端部署，支持以下设备类型：
- **phone**: 手机设备
- **pad**: 平板设备  
- **tablet**: 大屏平板设备
- **2in1**: 2in1折叠设备

### 资源目录结构

项目已创建针对不同设备的资源目录：
- `entry/src/main/resources/phone/` - 手机端专用资源
- `entry/src/main/resources/tablet/` - 平板端专用资源
- `entry/src/main/resources/2in1/` - 2in1设备专用资源
- `entry/src/main/resources/base/` - 通用资源
- `entry/src/main/resources/dark/` - 深色模式资源

每个设备目录包含：
- `element/` - 字符串、颜色、尺寸等资源
- `media/` - 图片等媒体资源
- `profile/` - 配置文件

### 设备适配

在 `entry/src/main/module.json5` 中已配置支持的设备类型：
```json5
"deviceTypes": [
  "phone",
  "tablet", 
  "2in1"
]
```

系统会根据当前设备自动加载对应的资源文件，实现界面和体验的差异化适配。

如需我把流程改为直接调用特定 hvigor 参数（例如指定任务或并行执行），请告诉我常用的 hvigor 命令行参数或允许我尝试在本机进行 dry-run。
