// @ts-nocheck
// src/services/firebase.ts
import { initializeApp } from 'firebase/app'

// 幾乎必備的兩個服務
import { getAuth } from 'firebase/auth'
import { getFirestore } from 'firebase/firestore'

const firebaseConfig = {
  // 個人配置
}

const app = initializeApp(firebaseConfig)
const auth = getAuth(app)
const db = getFirestore(app)

export { auth, db }
