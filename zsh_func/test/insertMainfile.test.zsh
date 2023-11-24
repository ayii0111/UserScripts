#!/bin/zsh

# 保存當前目錄
current_dir=$(pwd)

# 創建臨時測試目錄
test_dir=$(mktemp -d)
cd "$test_dir"

# 創建測試環境
mkdir -p src

# 測試案例 1: 當 main.ts 和 main.js 都不存在時
echo "測試案例 1: 當 main.ts 和 main.js 都不存在時"
if ! insertMainfile "import test" "app.use(test)"; then
  echo " \e[32m✔\e[0m 案例 1 通過：正確檢測到 main 檔不存在"
else
  echo " \e[31m✗\e[0m 案例 1 失敗：未能正確檢測 main 檔不存在的情況"
fi

# 測試案例 2: 當 main.ts 存在但缺少必要代碼時
echo "\n測試案例 2: 當 main.ts 存在但缺少必要代碼時"
echo "import { createApp } from 'vue'" >src/main.ts
if ! insertMainfile "import test" "app.use(test)"; then
  echo " \e[32m✔\e[0m 案例 2 通過：正確檢測到缺少必要代碼"
else
  echo " \e[31m✗\e[0m 案例 2 失敗：未能正確檢測缺少必要代碼的情況"
fi

# 測試案例 3: 正確插入代碼到 main.ts
echo "\n測試案例 3: 正確插入代碼到 main.ts"
cat >src/main.ts <<'EOL'
import { createApp } from 'vue'
import App from './App.vue'

const app = createApp(App)
app.mount('#app')
EOL

if insertMainfile "import test from 'test'" "app.use(test)"; then
  # 驗證插入結果
  if grep -q "import test from 'test'" src/main.ts && grep -q "app.use(test)" src/main.ts; then
    echo " \e[32m✔\e[0m 案例 3 通過：成功插入代碼到 main.ts"
  else
    echo " \e[31m✗\e[0m 案例 3 失敗：代碼插入不完整"
  fi
else
  echo " \e[31m✗\e[0m 案例 3 失敗：插入代碼過程出錯"
fi

# 測試案例 4: 測試 main.js 的情況
echo "\n測試案例 4: 測試 main.js 的情況"
rm src/main.ts
cat >src/main.js <<'EOL'
import { createApp } from 'vue'
import App from './App.vue'

const app = createApp(App)
app.mount('#app')
EOL

if insertMainfile "import test from 'test'" "app.use(test)"; then
  if grep -q "import test from 'test'" src/main.js && grep -q "app.use(test)" src/main.js; then
    echo " \e[32m✔\e[0m 案例 4 通過：成功插入代碼到 main.js"
  else
    echo " \e[31m✗\e[0m 案例 4 失敗：代碼插入不完整"
  fi
else
  echo " \e[31m✗\e[0m 案例 4 失敗：插入代碼過程出錯"
fi

# 清理測試環境
cd "$current_dir"
rm -rf "$test_dir"
