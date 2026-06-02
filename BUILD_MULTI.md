**多端构建说明（phone + pad）**

本说明配合仓库中的 `build-profile.phone.json5` 与 `build-profile.pad.json5` 使用，脚本位于 `scripts/`。

用法：在 Windows 上可运行 `scripts\\build-multi.bat`，在 PowerShell 上可运行 `scripts\\build-multi.ps1`。

脚本会：
- 备份当前 `build-profile.json5`（第一次运行时创建 `build-profile.backup.json5`）
- 依次将 `build-profile.phone.json5` 与 `build-profile.pad.json5` 覆盖 `build-profile.json5`，并尝试调用 `hvigor`（若 `hvigor` 在 PATH 或由 DevEco Studio 提供）
- 完成后恢复原始 `build-profile.json5`

注意事项：
- 脚本不会修改源码或 UI 文件——仅替换构建配置以实现一次开发，多端构建输出。
- 如果你的构建流程由 IDE（如 DevEco Studio）管理，脚本仍会替换配置文件，随后你可以在 IDE 中触发构建。

如需我把流程改为直接调用特定 hvigor 参数（例如指定任务或并行执行），请告诉我常用的 hvigor 命令行参数或允许我尝试在本机进行 dry-run。
