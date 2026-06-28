<p align="center">
  <img src="assets/readme-banner.svg" alt="たねつみの歌 中日二言語字幕パッチ" width="100%">
</p>

# 『たねつみの歌』中日二言語字幕パッチ

[中文](README.md) | [English](README.en.md) | [日本語](README.ja.md)

[![Release](https://img.shields.io/github/v/release/RubyonLy0929/tanetsumi-bilingual-subtitle-patch?label=download&color=2f6f9f)](https://github.com/RubyonLy0929/tanetsumi-bilingual-subtitle-patch/releases/latest)
[![Steam](https://img.shields.io/badge/Steam-guide-1b75d0)](https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194)
[![License](https://img.shields.io/github/license/RubyonLy0929/tanetsumi-bilingual-subtitle-patch)](LICENSE)
[![Game](https://img.shields.io/badge/Tanetsumi%20no%20Uta-2748830-f0b35a)](https://store.steampowered.com/app/2748830/)

日本語学習者向けの『たねつみの歌 / Tanetsumi no Uta / 播种之谣』非公式字幕パッチです。会話シーンで、上段に公式日本語字幕、下段に簡体字中国語の補助字幕を同時表示します。

役に立った場合は、GitHub 右上の Star を押していただけると、他の日本語学習者にも見つけてもらいやすくなります。

## ダウンロード

- 推奨：[最新版リリースパッケージ](https://github.com/RubyonLy0929/tanetsumi-bilingual-subtitle-patch/releases/latest)
- 手動導入用：[tanetsumi.pfs.099](dist/tanetsumi.pfs.099?raw=1)
- スクリーンショット付き Steam ガイド：https://steamcommunity.com/sharedfiles/filedetails/?id=3753328194

## 表示内容

| 位置 | 表示内容 | 説明 |
| --- | --- | --- |
| 上段 | 公式日本語字幕 | 元の大きなメイン字幕を維持 |
| 下段 | 公式簡体字中国語字幕 | 小さめの淡黄色補助字幕 |
| UI | ゲーム内の言語設定 | メニューや設定画面はゲーム設定に従う |

検索キーワード：たねつみの歌 二言語字幕、Tanetsumi no Uta bilingual subtitles、播种之谣双语字幕、日本語学習、visual novel patch。

## 品質チェック

このバージョンは全シナリオに対してレイアウト確認を行っています。

- 83 個のシナリオファイル
- 16,712 個の会話ブロック
- 画面外にはみ出す危険な重なりは未検出
- 最も詰まった長文ケースでも約 56px の下部余白を確認

## 対応環境

- ゲーム：Steam 版『たねつみの歌 / Tanetsumi no Uta / 播种之谣』
- Steam App ID：`2748830`
- プラットフォーム：Windows
- パッチファイル：`tanetsumi.pfs.099`

ゲームアップデート後に表示が崩れた場合は、いったん本パッチをアンインストールしてから、対応版をお待ちください。

## インストール

### 方法 1：インストールスクリプト

1. `tanetsumi-bilingual-subtitle-patch-v1.0.0.zip` をダウンロードします。
2. 任意の場所に展開します。
3. `install.bat` を実行します。
4. スクリプトがゲームフォルダを見つけられない場合は、`tanetsumi.exe` があるフォルダを指定します。
5. ゲームを再起動します。

### 方法 2：手動導入

1. `tanetsumi.pfs.099` をダウンロードします。
2. Steam のローカルファイルフォルダを開きます。
3. `tanetsumi.exe` と同じ場所に `tanetsumi.pfs.099` を置きます。
4. ゲームを再起動します。

## アンインストール

`uninstall.bat` を実行するか、ゲームフォルダから `tanetsumi.pfs.099` を削除してください。

## チェックサム

```text
tanetsumi.pfs.099
SHA256: C08151EF0AF6F44261CBD3EACB90C9FF1C37D0723A639C7D63011F591F4F6BAB

tanetsumi-bilingual-subtitle-patch-v1.0.0.zip
SHA256: 8701762948EE1ABF04C332C2C6BB3BCCC31059A63A36F4D32C34A221E2FC0FF3
```

## 免責事項

これはファン制作の非公式パッチです。開発元、販売元、Steam、その他権利者とは関係ありません。ゲーム本体、シナリオ本文、画像、音声、動画、DRM 回避手段は含まれていません。正規に購入した Steam 版で使用してください。
