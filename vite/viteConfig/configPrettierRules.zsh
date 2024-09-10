#! /bin/zsh

local overrides='
  "overrides": [
    {
      "files": "*.scss",
      "options": {
        "singleQuote": false
      }
    }
  ],
'
overrides=$(echo "$overrides" | gsed ':a;N;$!ba;s/\n/\\n/g')
gsed -i "/semi*.: false,/ s|$|$overrides|" .prettierrc.json 2>/dev/null

# 將寬度提高，以避免 html 標籤的屬性會過度換行
gsed -i '/"printWidth":/ s|^.*$|  "printWidth": 250,|' .prettierrc.json 2>/dev/null


unset overrides