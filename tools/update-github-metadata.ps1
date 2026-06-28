param(
    [string]$Repository = "RubyonLy0929/tanetsumi-bilingual-subtitle-patch",
    [string]$SteamGuideUrl = "https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194"
)

$ErrorActionPreference = "Stop"

if (-not $env:GITHUB_TOKEN) {
    throw "Set GITHUB_TOKEN to a GitHub token with repo metadata/release write permission before running this script."
}

$headers = @{
    Authorization = "Bearer $env:GITHUB_TOKEN"
    Accept = "application/vnd.github+json"
    "X-GitHub-Api-Version" = "2022-11-28"
}

$repoApi = "https://api.github.com/repos/$Repository"

$repoBody = @{
    description = "《播种之谣 / たねつみの歌 / Tanetsumi no Uta》日语学习者用日中双语字幕补丁"
    homepage = $SteamGuideUrl
    has_issues = $true
} | ConvertTo-Json

Invoke-RestMethod -Uri $repoApi -Method Patch -Headers $headers -Body $repoBody -ContentType "application/json" | Out-Null

$topicsBody = @{
    names = @(
        "tanetsumi-no-uta",
        "visual-novel",
        "japanese-learning",
        "bilingual-subtitles",
        "steam",
        "windows",
        "mod",
        "patch",
        "lua",
        "chinese",
        "japanese"
    )
} | ConvertTo-Json

Invoke-RestMethod -Uri "$repoApi/topics" -Method Put -Headers $headers -Body $topicsBody -ContentType "application/json" | Out-Null

$latestRelease = Invoke-RestMethod -Uri "$repoApi/releases/latest" -Method Get -Headers $headers

$releaseBody = @"
# v1.0.0 - 日语学习者用日中双语字幕补丁

这是《播种之谣 / たねつみの歌 / Tanetsumi no Uta》的非官方双语字幕补丁，面向想边玩边学日语的玩家。

## 推荐下载

- ``tanetsumi-bilingual-subtitle-patch-v1.0.0.zip``：推荐下载，包含补丁、安装/卸载脚本和说明。
- ``tanetsumi.pfs.099``：手动安装用补丁文件。

## 主要效果

- 对白固定显示日语主字幕 + 简体中文辅助字幕。
- 中文字幕固定淡黄色显示，避免读档后颜色漂移。
- UI 语言继续跟随游戏设置，不锁死成中文或日文。
- 已完成全剧本排版扫描：83 个剧本文件、16712 个对白块。

## 图文指南

Steam 指南：
$SteamGuideUrl

## SHA256

- ``tanetsumi.pfs.099``: ``C08151EF0AF6F44261CBD3EACB90C9FF1C37D0723A639C7D63011F591F4F6BAB``
- ``tanetsumi-bilingual-subtitle-patch-v1.0.0.zip``: ``8701762948EE1ABF04C332C2C6BB3BCCC31059A63A36F4D32C34A221E2FC0FF3``

如果这个补丁帮到了你，欢迎给仓库点 Star。Star 会让更多日语学习者和《播种之谣》玩家看到它。
"@

$releasePatch = @{
    name = "v1.0.0 - 日语学习者用日中双语字幕补丁"
    body = $releaseBody
} | ConvertTo-Json

Invoke-RestMethod -Uri "$repoApi/releases/$($latestRelease.id)" -Method Patch -Headers $headers -Body $releasePatch -ContentType "application/json" | Out-Null

Write-Host "Updated repository description, homepage, topics, and latest release metadata."
