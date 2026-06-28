# GitHub 曝光优化清单

这份清单用于把项目包装成更容易被搜索、理解、下载和转发的公开仓库。它不包含刷星、买星或机器人互动；这些做法不稳定，也会损害项目可信度。

## 仓库元信息

建议仓库描述：

```text
《播种之谣 / たねつみの歌 / Tanetsumi no Uta》日语学习者用日中双语字幕补丁
```

建议 Homepage：

```text
https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194
```

建议 Topics：

```text
tanetsumi-no-uta
visual-novel
japanese-learning
bilingual-subtitles
steam
windows
mod
patch
lua
chinese
japanese
```

## Release v1.0.0 推荐文案

```markdown
# v1.0.0 - 日语学习者用日中双语字幕补丁

这是《播种之谣 / たねつみの歌 / Tanetsumi no Uta》的非官方双语字幕补丁，面向想边玩边学日语的玩家。

## 推荐下载

- `tanetsumi-bilingual-subtitle-patch-v1.0.0.zip`：推荐下载，包含补丁、安装/卸载脚本和说明。
- `tanetsumi.pfs.099`：手动安装用补丁文件。

## 主要效果

- 对白固定显示日语主字幕 + 简体中文辅助字幕。
- 中文字幕固定淡黄色显示，避免读档后颜色漂移。
- UI 语言继续跟随游戏设置，不锁死成中文或日文。
- 已完成全剧本排版扫描：83 个剧本文件、16712 个对白块。

## 图文指南

Steam 指南：
https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194

## SHA256

- `tanetsumi.pfs.099`: `C08151EF0AF6F44261CBD3EACB90C9FF1C37D0723A639C7D63011F591F4F6BAB`
- `tanetsumi-bilingual-subtitle-patch-v1.0.0.zip`: `8701762948EE1ABF04C332C2C6BB3BCCC31059A63A36F4D32C34A221E2FC0FF3`

如果这个补丁帮到了你，欢迎给仓库点 Star。Star 会让更多日语学习者和《播种之谣》玩家看到它。
```

## 可执行推广动作

- GitHub：更新 README、Topics、Homepage、Release 文案。
- GitHub Social preview：使用 `assets/social-preview.svg` 导出为 PNG 后上传到仓库 Settings 的 Social preview。
- Steam：在指南正文保留 GitHub Release 链接，并在评论区置顶“如果有帮助欢迎 Star GitHub 仓库”的自然说明。
- B 站/贴吧/QQ群/Discord：使用 `PROMOTION.md` 中的短文案，附 GitHub 链接和 Steam 指南链接。
- Issues：启用模板，让遇到问题的人更容易反馈，而不是直接离开。
- README：首屏必须包含下载入口、效果说明、Steam 指南、Star 引导和关键词。

## 授权后一键更新

如果本地已经有 GitHub token，可以运行：

```powershell
$env:GITHUB_TOKEN="ghp_xxx"
.\tools\update-github-metadata.ps1
```

这个脚本会更新仓库描述、Homepage、Topics 和最新版 Release 文案。

## 不建议做的事

- 不刷 star，不买 star，不使用机器人互动。
- 不在无关社区刷屏。
- 不声称这是官方补丁。
- 不承诺会影响成就或完全无风险，只说明补丁不主动修改存档、进程和 Steam 接口。
