<script setup lang="ts">
// Auto-resize textarea 元件
const textarea = ref<HTMLTextAreaElement | null>(null)
const modelValue = defineModel<string>()

// 提供初始高度 prop 可以使用
let { initailHeight } = withDefaults(
  defineProps<{
    initailHeight?: string
  }>(),
  { initailHeight: '88px' }
) // 默認的初始高度

// Auto-resize textarea 自動縮放的多行輸入框
function resize() {
  textarea.value!.style.height = initailHeight
  textarea.value!.style.height = textarea.value!.scrollHeight + 'px'
}
</script>

<template>
  <textarea
    v-model="modelValue"
    ref="textarea"
    @input="resize()"
    :style="{ height: initailHeight }"></textarea>
</template>
<style scoped lang="scss"></style>
