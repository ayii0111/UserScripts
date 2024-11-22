#! /bin/zsh

(
  checkNoInst vue3-json-viewer || return 1
  npm install clipboard --save
  npm install vue3-json-viewer --save

  local importSnip="import JsonViewer from 'vue3-json-viewer'
import 'vue3-json-viewer/dist/index.css'
"
  local useSnip="app.use(JsonViewer)"
  insertMainfile $importSnip $useSnip

  echo "declare module 'vue3-json-viewer' {
    import { AllowedComponentProps, App, Component, ComponentCustomProps, VNodeProps } from 'vue'
    interface JsonViewerProps {
        value: Object | Array<any> | string | number | boolean; //对象
        expanded: boolean; //是否自动展开
        expandDepth: number; //展开层级
        copyable: boolean | object; //是否可复制
        sort: boolean;//是否排序
        boxed: boolean;//是否boxed
        theme: string;//主题 jv-dark | jv-light
        previewMode: boolean;//是否可复制
        timeformat: (value: any) => string
    }
    type JsonViewerType = JsonViewerProps & VNodeProps & AllowedComponentProps & ComponentCustomProps
    const JsonViewer: Component<JsonViewerType>
    export { JsonViewer }
    const def: { install: (app: App) => void }
    export default def
}
" >./node_modules/vue3-json-viewer/index.d.ts

  echo ".jv-node.jv-key-node::before {
  content: '▪︎';
  color: #666666;
  margin-right: 4px;
}

.jv-node .jv-node {
  margin-left: 13px;
}
" >>./node_modules/vue3-json-viewer/dist/index.css
)
