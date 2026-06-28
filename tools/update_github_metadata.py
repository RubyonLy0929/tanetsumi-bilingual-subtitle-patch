# -*- coding: utf-8 -*-
"""Update GitHub repository metadata for this project.

Requires a GITHUB_TOKEN environment variable with permission to edit repository
metadata, topics, and releases.
"""

from __future__ import annotations

import json
import os
import sys
import urllib.error
import urllib.request


REPOSITORY = "RubyonLy0929/tanetsumi-bilingual-subtitle-patch"
STEAM_GUIDE_URL = "https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194"
API_ROOT = f"https://api.github.com/repos/{REPOSITORY}"


def request(method: str, url: str, token: str, payload: dict | None = None) -> dict:
    data = None if payload is None else json.dumps(payload, ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(
        url,
        data=data,
        method=method,
        headers={
            "Authorization": f"Bearer {token}",
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28",
            "Content-Type": "application/json",
            "User-Agent": "tanetsumi-bilingual-subtitle-patch-maintenance",
        },
    )
    try:
        with urllib.request.urlopen(req, timeout=30) as resp:
            body = resp.read().decode("utf-8")
            return {} if not body else json.loads(body)
    except urllib.error.HTTPError as exc:
        detail = exc.read().decode("utf-8", errors="replace")
        raise RuntimeError(f"GitHub API {method} {url} failed: {exc.code} {detail}") from exc


def main() -> int:
    token = os.environ.get("GITHUB_TOKEN")
    if not token:
        print("Set GITHUB_TOKEN before running this script.", file=sys.stderr)
        return 2

    request(
        "PATCH",
        API_ROOT,
        token,
        {
            "description": "《播种之谣 / たねつみの歌 / Tanetsumi no Uta》日语学习者用日中双语字幕补丁",
            "homepage": STEAM_GUIDE_URL,
            "has_issues": True,
        },
    )

    request(
        "PUT",
        f"{API_ROOT}/topics",
        token,
        {
            "names": [
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
                "japanese",
            ]
        },
    )

    latest_release = request("GET", f"{API_ROOT}/releases/latest", token)
    release_body = f"""# v1.0.0 - 日语学习者用日中双语字幕补丁

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
{STEAM_GUIDE_URL}

## SHA256

- `tanetsumi.pfs.099`: `C08151EF0AF6F44261CBD3EACB90C9FF1C37D0723A639C7D63011F591F4F6BAB`
- `tanetsumi-bilingual-subtitle-patch-v1.0.0.zip`: `8701762948EE1ABF04C332C2C6BB3BCCC31059A63A36F4D32C34A221E2FC0FF3`

如果这个补丁帮到了你，欢迎给仓库点 Star。Star 会让更多日语学习者和《播种之谣》玩家看到它。
"""

    request(
        "PATCH",
        f"{API_ROOT}/releases/{latest_release['id']}",
        token,
        {
            "name": "v1.0.0 - 日语学习者用日中双语字幕补丁",
            "body": release_body,
        },
    )

    print("Updated repository description, homepage, topics, and latest release metadata.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
