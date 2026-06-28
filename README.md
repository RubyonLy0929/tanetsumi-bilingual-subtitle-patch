<p align="center">
  <img src="assets/readme-banner.svg" alt="播种之谣 / たねつみの歌 日中双语字幕补丁" width="100%">
</p>

# 《播种之谣》日中双语字幕补丁

[中文](README.md) | [English](README.en.md) | [日本語](README.ja.md)

[![Release](https://img.shields.io/github/v/release/RubyonLy0929/tanetsumi-bilingual-subtitle-patch?label=download&color=2f6f9f)](https://github.com/RubyonLy0929/tanetsumi-bilingual-subtitle-patch/releases/latest)
[![Steam](https://img.shields.io/badge/Steam-指南-1b75d0)](https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194)
[![License](https://img.shields.io/github/license/RubyonLy0929/tanetsumi-bilingual-subtitle-patch)](LICENSE)
[![Game](https://img.shields.io/badge/Tanetsumi%20no%20Uta-2748830-f0b35a)](https://store.steampowered.com/app/2748830/)

面向日语学习者的《播种之谣 / たねつみの歌 / Tanetsumi no Uta》非官方双语字幕补丁。安装后，对白场景会同时显示 **日语主字幕** 和 **简体中文辅助字幕**，适合边玩边学日语、对照理解台词表达。

> 如果这个项目帮到了你，欢迎点一下 GitHub 右上角的 Star。Star 会让更多正在学日语、正在玩《播种之谣》的玩家更容易看到它。

## 快速下载

- 推荐下载：[tanetsumi-bilingual-subtitle-patch-v1.0.0.zip](https://github.com/RubyonLy0929/tanetsumi-bilingual-subtitle-patch/releases/latest)
- 手动安装：[tanetsumi.pfs.099](dist/tanetsumi.pfs.099?raw=1)
- 图文说明：[Steam 指南](https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194)

## 这个补丁做了什么

| 位置 | 显示内容 | 说明 |
| --- | --- | --- |
| 上方 | 日语官方字幕 | 保留原本的大字主字幕效果 |
| 下方 | 简体中文官方字幕 | 淡黄色、小一号，作为理解辅助 |
| UI | 游戏设置中的语言 | 菜单、设置、按钮不会被锁成中文或日文 |

关键词：播种之谣双语字幕、たねつみの歌 二言語字幕、Tanetsumi no Uta bilingual subtitles、日语学习、Japanese learning visual novel patch。

## 效果与质量检查

安装后，游戏对白界面会以日语为主字幕、简体中文为副字幕。中文字幕会始终保持淡黄色，不会因为已读状态变白；读档后的第一句也不会重复显示。

这个版本已经用全剧本做过排版扫描：**83 个剧本文件、16712 个对白块**，未发现越界或危险重叠。最挤的长句仍保留约 **56px** 底部余量。

更多效果图见 Steam 指南：

https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194

## 适用版本

- 游戏：Steam 版《播种之谣 / たねつみの歌 / Tanetsumi no Uta》
- App ID：`2748830`
- 平台：Windows
- 补丁文件：`tanetsumi.pfs.099`

如果游戏更新后字幕显示异常，可以先卸载本补丁，等待新版本适配。

## 安装方法

### 方法一：使用安装脚本

1. 下载 `tanetsumi-bilingual-subtitle-patch-v1.0.0.zip`
2. 解压到任意位置
3. 双击 `install.bat`
4. 如果脚本没有自动找到游戏目录，按提示输入游戏目录路径
5. 重新启动游戏

游戏目录通常类似：

```text
D:\SteamLibrary\steamapps\common\Tanetsumi_no_uta
```

### 方法二：手动安装

1. 下载 `tanetsumi.pfs.099`
2. 打开 Steam 游戏本地文件目录
3. 把 `tanetsumi.pfs.099` 放到游戏根目录，也就是 `tanetsumi.exe` 所在目录
4. 重新启动游戏

如果目录里已经有 `tanetsumi.pfs.099`，请先备份原文件。

## 卸载方法

### 方法一：使用卸载脚本

双击 `uninstall.bat`。

如果你安装前原本就有同名补丁，并且安装脚本生成了备份，可以在 PowerShell 中运行：

```powershell
.\tools\uninstall.ps1 -RestoreBackup
```

### 方法二：手动卸载

删除游戏目录里的这个文件：

```text
tanetsumi.pfs.099
```

然后重新启动游戏即可恢复原版显示。

## 文件校验

```text
tanetsumi.pfs.099
SHA256: C08151EF0AF6F44261CBD3EACB90C9FF1C37D0723A639C7D63011F591F4F6BAB

tanetsumi-bilingual-subtitle-patch-v1.0.0.zip
SHA256: 8701762948EE1ABF04C332C2C6BB3BCCC31059A63A36F4D32C34A221E2FC0FF3
```

完整校验列表见 [checksums.sha256](checksums.sha256)。

## 常见问题

### 设置里切换语言后会怎样？

对白字幕仍会固定为日语主字幕 + 简体中文副字幕。菜单、设置、按钮等 UI 文字继续跟随游戏设置。

### 会影响存档吗？

不会。这个补丁只改显示逻辑，不改存档内容。卸载后存档可以继续使用。

### 会影响成就吗？

补丁不修改游戏进程、存档和 Steam 接口；理论上不会影响成就。不过任何非官方补丁都建议自行承担使用风险。

### 可以和其他补丁一起用吗？

如果其他补丁也使用 `tanetsumi.pfs.099`，会发生冲突。安装脚本会在覆盖前备份原文件，但不能自动合并多个补丁。

### 为什么不是游戏设置里的双字幕选项？

原游戏只允许实时切换单一字幕语言。本补丁通过额外显示副字幕层，让日语学习者可以同时看到日语和简体中文。

## 帮助项目被更多人看到

你可以做这些小事支持项目：

- 在 GitHub 右上角点 Star
- 在 Steam 指南里收藏或点赞
- 把项目分享给正在学日语、正在玩《播种之谣》的朋友
- 遇到问题时提交 Issue，帮助后续版本改进兼容性

可复制的分享文案见 [PROMOTION.md](PROMOTION.md)。

## 支持作者

如果这个补丁帮到了你，可以扫码支持作者继续制作学习向补丁和工具。

![打赏二维码](assets/support-qr.jpg)

## 免责声明

这是玩家制作的非官方补丁，与游戏开发商、发行商、Steam 或相关权利方无关。

请先购买并安装正版游戏。本项目不提供游戏本体，不绕过 DRM，不分发剧情脚本、图片、音频、视频等游戏内容。所有游戏相关权利归原权利方所有。

## 许可证

仓库中的说明文档、安装脚本和自制 Lua 逻辑以 MIT License 发布。游戏本体及其相关资源不在本许可证范围内。
