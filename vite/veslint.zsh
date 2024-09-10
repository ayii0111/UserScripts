# 安裝
npm i -D eslint@^9.10.0 @antfu/eslint-config eslint-plugin-format

# 將預設的 eslint 改變格式
# 整個預設檔刪除，建立新的
rm .eslintrc.cjs

echo "import antfu from '@antfu/eslint-config'

export default antfu()" >eslint.config.mjs

echo '{
  // Disable the default formatter, use eslint instead
  "prettier.enable": false,
  "editor.formatOnSave": true,

  // Auto fix
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": "explicit",
    "source.organizeImports": "never"
  },

  // Silent the stylistic rules in you IDE, but still auto fix them
  "eslint.rules.customizations": [
    { "rule": "style/*", "severity": "off", "fixable": true },
    { "rule": "format/*", "severity": "off", "fixable": true },
    { "rule": "*-indent", "severity": "off", "fixable": true },
    { "rule": "*-spacing", "severity": "off", "fixable": true },
    { "rule": "*-spaces", "severity": "off", "fixable": true },
    { "rule": "*-order", "severity": "off", "fixable": true },
    { "rule": "*-dangle", "severity": "off", "fixable": true },
    { "rule": "*-newline", "severity": "off", "fixable": true },
    { "rule": "*quotes", "severity": "off", "fixable": true },
    { "rule": "*semi", "severity": "off", "fixable": true }
  ],

  // Enable eslint for all supported languages
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
    "html",
    "markdown",
    "json",
    "jsonc",
    "yaml",
    "toml",
    "xml",
    "gql",
    "graphql",
    "astro",
    "svelte",
    "css",
    "less",
    "scss",
    "pcss",
    "postcss"
  ]
}' >.vscode/settings.json

# 覆蓋 eslint.config.mjs 檔的內容
echo "// eslint.config.js
import antfu from '@antfu/eslint-config'

export default antfu(
  {
    formatters: {
      css: true,
      html: true,
      markdown: 'prettier',
    },
  },
  {
    rules: {
      'no-console': 0, // 禁用 console
      'ts/no-unused-expressions': 0, // 預期有一個賦值或函數調用，但卻看到了一個表達式
      'ts/no-use-before-define': 0, // 宣告前使用
      'no-eval': 0, // 禁用 eval()
      'vue/attribute-hyphenation': 0, // 標籤屬性需使用「連字號」連結
      'vue/require-toggle-inside-transition': 0, // <transition> 的子元素需要有 v-if 或 v-show，隔層就不行（太嚴格）
      'unused-imports/no-unused-vars': 0, // 變數未使用
      'no-empty': 0, // if {  } 內為空
      'vue/html-self-closing': 0, // 不檢查 <自定標籤 /> 的代碼
      'no-prototype-builtins': 0, //  解除 obj.hasOwnProperty() 的禁用
      'ts/consistent-type-definitions': 0, // 能使用 interface 就不要用 type
      'curly': ['error', 'multi-line'], // 這個要設定要加大括號，才能與 if 擠一行（莫名其妙）
      'style/max-statements-per-line': 0, // 限制每行的 statement 數量
      'no-unused-expressions': 0,  // 可以僅使用「條件式 ? true: null 而不會報錯」
    },
  },
)" >eslint.config.mjs

# 操作 vscode 執行 reload 指令
osascript <<EOF
tell application "Visual Studio Code"
  activate
  delay 0.5
  tell application "System Events"
    keystroke "p" using {command down, shift down}
    delay 0.5
    keystroke "reload window"
    delay 0.5
    key code 36 -- Press Enter
  end tell
end tell
EOF
