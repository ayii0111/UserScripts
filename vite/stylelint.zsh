#! /bin/zsh


# 別名 vstylint
npm i -D stylelint \
stylelint-config-standard-scss \
stylelint-config-recommended-vue \
stylelint-order \
postcss \
postcss-html \
postcss-scss


echo 'module.exports = {
  extends: [
    "stylelint-config-standard-scss",
    "stylelint-config-recommended-vue",
  ],
  plugins: ["stylelint-order"],
  overrides: [
    {
      files: ["**/*.(scss|css|html|vue)"],
      customSyntax: "postcss-scss",
    },
    {
      files: ["**/*.(html|vue)"],
      customSyntax: "postcss-html",
    },
  ],
  rules: {
    "scss/dollar-variable-colon-space-before": null, // 屬性與冒號之間不要有空格
    "scss/dollar-variable-colon-space-after": null, // 冒號之後不要有空格
    "scss/double-slash-comment-empty-line-before": null, // 註解上面要留一行空行
    "scss/dollar-variable-empty-line-before": null, // 變數定義行的上面一行，不能是空行
    "scss/function-quote-no-quoted-strings-inside": null, // 與函式有關的不知蝦米挖歌的規定
    "block-no-empty": null, // 花括號裡面的代碼是空的
    "max-nesting-depth": null, // 選擇器深度上限2層
    "no-descending-specificity": null, // 與同層選擇器的先後順序以及特殊性有關
    "selector-no-qualifying-type": null, // 類別選擇器前面不需添加元素
    "rule-empty-line-before": null, // scss 花括號內的選擇器，不要與 { 直接有個空行
    "selector-max-compound-selectors": null, // 選擇器上限複合數量2個
    "declaration-block-trailing-semicolon": "always", // 始終自動添加分號
    "selector-attribute-quotes": null, // 選擇器中的[]內要使用""
    "custom-property-empty-line-before": null, // css變數定義的上面一行要空行
    "declaration-empty-line-before": null, // 變數定義下面要與其他一般屬性間隔一行空行
    "number-max-precision": null, // 數字位數限制
    "value-no-vendor-prefix": null,
    "shorthand-property-no-redundant-values": null,
    "selector-no-vendor-prefix": null,
    "no-duplicate-selectors": null,
    "declaration-block-no-redundant-longhand-properties": null,
    "function-name-case": null,
    "at-rule-empty-line-before": null,
    "media-feature-range-notation": null,
    "selector-not-notation": null,
    "no-irregular-whitespace": null,
    "value-keyword-case": null,
    "property-no-vendor-prefix": null,
    "max-line-length": null,
    "selector-class-pattern": null,
    "function-parentheses-newline-inside": null,
    "at-rule-no-unknown": null,
    "color-function-notation": "legacy",
    "alpha-value-notation": "number",
    "scss/no-global-function-names": null,
    "scss/comment-no-empty": null,
    "no-invalid-position-at-import-rule": null,
    "order/properties-order": [
      "position",
      "top",
      "right",
      "bottom",
      "left",
      "z-index",
      "display",
      "flex-wrap",
      "justify-content",
      "align-items",
      "float",
      "clear",
      "overflow",
      "overflow-x",
      "overflow-y",
      "padding",
      "padding-top",
      "padding-right",
      "padding-bottom",
      "padding-left",
      "margin",
      "margin-top",
      "margin-right",
      "margin-bottom",
      "margin-left",
      "width",
      "min-width",
      "max-width",
      "height",
      "min-height",
      "max-height",
      "font-size",
      "font-family",
      "font-weight",
      "text-justify",
      "text-align",
      "text-indent",
      "text-overflow",
      "text-decoration",
      "white-space",
      "color",
      "background",
      "background-position",
      "background-repeat",
      "background-size",
      "background-color",
      "background-clip",
      "border",
      "border-style",
      "border-width",
      "border-color",
      "border-top-style",
      "border-top-width",
      "border-top-color",
      "border-right-style",
      "border-right-width",
      "border-right-color",
      "border-bottom-style",
      "border-bottom-width",
      "border-bottom-color",
      "border-left-style",
      "border-left-width",
      "border-left-color",
      "border-radius",
      "opacity",
      "filter",
      "list-style",
      "outline",
      "visibility",
      "box-shadow",
      "text-shadow",
      "resize",
      "transition",
    ],
  },
};' > .stylelintrc.js
