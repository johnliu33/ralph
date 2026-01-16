#!/bin/bash

# install-ralph.sh
# 將 ralph.sh 和 prompt.md 安裝到目標專案的 scripts/ralph/ 目錄

set -e

# 取得腳本所在的目錄（即 ralph 專案的根目錄）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 檢查是否提供了目標專案路徑
if [ -z "$1" ]; then
    echo "❌ 錯誤：請提供目標專案路徑"
    echo ""
    echo "使用方式：$0 /path/to/target-project"
    exit 1
fi

TARGET_PROJECT="$1"

# 如果目標路徑是相對路徑，轉換為絕對路徑
if [[ "$TARGET_PROJECT" != /* ]]; then
    TARGET_PROJECT="$(cd "$TARGET_PROJECT" 2>/dev/null && pwd)" || {
        # 如果目錄不存在，則基於當前工作目錄創建絕對路徑
        TARGET_PROJECT="$(pwd)/$1"
    }
fi

TARGET_DIR="$TARGET_PROJECT/scripts/ralph"

echo "📦 正在安裝 Ralph 到：$TARGET_PROJECT"
echo ""

# 檢查來源檔案是否存在
if [ ! -f "$SCRIPT_DIR/ralph.sh" ]; then
    echo "❌ 錯誤：找不到 $SCRIPT_DIR/ralph.sh"
    exit 1
fi

if [ ! -f "$SCRIPT_DIR/prompt.md" ]; then
    echo "❌ 錯誤：找不到 $SCRIPT_DIR/prompt.md"
    exit 1
fi

# 創建目標目錄（如果不存在）
echo "📁 創建目錄：$TARGET_DIR"
mkdir -p "$TARGET_DIR"

# 複製檔案
echo "📄 複製 ralph.sh..."
cp "$SCRIPT_DIR/ralph.sh" "$TARGET_DIR/"

echo "📄 複製 prompt.md..."
cp "$SCRIPT_DIR/prompt.md" "$TARGET_DIR/"

# 設置執行權限
echo "🔧 設置執行權限..."
chmod +x "$TARGET_DIR/ralph.sh"

echo ""
echo "✅ 安裝完成！"
echo ""
echo "已安裝的檔案："
echo "  - $TARGET_DIR/ralph.sh"
echo "  - $TARGET_DIR/prompt.md"
