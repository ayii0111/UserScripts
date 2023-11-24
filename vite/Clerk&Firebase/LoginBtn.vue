<script setup lang="ts">
import { SignInButton, useAuth, SignedIn, SignedOut } from 'vue-clerk'
import { Clerk } from '@clerk/clerk-js'
import { signInWithCustomToken } from 'firebase/auth'
import { auth } from '@services/firebase'

const clerkPubKey = import.meta.env.VITE_CLERK_PUBLISHABLE_KEY
const clerk = new Clerk(clerkPubKey)

const userButton = ref(null)
const isSignedIn = ref(true)
const currentUrl = computed(() => window.location.href)

const { getToken } = useAuth()

onMounted(async () => {
  await clerk.load()
  clerk.addListener(async (emission) => {
    if (emission.user) {
      console.log('Clerk 驗證為登入狀態')
      clerk.mountUserButton(userButton.value!)
      isSignedIn.value = true
      const token = await getToken.value({ template: 'integration_firebase' })
      console.log('token:', token)

      // 將 token 帶入 Firebase 的 signInWithCustomToken() 函式中來登入
      const userCredentials = await signInWithCustomToken(auth, token || '')

      // userCredentials.user 就相當於 auth.user
      console.log('User:', userCredentials.user)
    } else {
      console.log('Clerk 驗證為登出狀態')
      isSignedIn.value = false
      // 經 Clerk 監聽到登出後，再手動登出 firebase
      auth.signOut()
    }
  })
})
</script>
<template>
  <div class="auth">
    <SignedIn>
      <div ref="userButton"></div>
    </SignedIn>
    <SignedOut>
      <!-- 使用 :redirectUrl="currentUrl" mode="modal" 可以在登入後，仍在原來網頁 -->
      <SignInButton v-slot="{ handler }" :redirectUrl="currentUrl" mode="modal">
        <a class="icon-link" @click.prevent="handler" href="#">
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="16"
            height="16"
            fill="currentColor"
            class="bi bi-person-circle"
            viewBox="0 0 16 16">
            <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0" />
            <path
              fill-rule="evenodd"
              d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8m8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1" />
          </svg>
        </a>
      </SignInButton>
    </SignedOut>
  </div>
</template>
<style scoped lang="scss">
.auth {
  display: inline-block;
}
.bi {
  width: 32px;
  height: 32px;
}
.icon-link {
  color: #adb5bd;
  &:hover {
    color: #6c757d;
  }
}

// 雖不是 vue 元件，也可以透過 :deep 來修改
// 因為這個套件，僅有匯入 js，而沒有 css 推測其使用 css-in-js
// 由此可推論 :deep() 應該可以直接用來修改 css-in-js 的樣式
:deep() {
  .cl-userButtonTrigger {
    box-shadow: none;
  }

  .cl-avatarBox {
    width: 32px;
    height: 32px;
  }
}
</style>
