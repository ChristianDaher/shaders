<script setup>
import { useRouter } from "vue-router";

const router = useRouter();

const goBack = () => {
  router.push('/');
};
</script>

<template>
  <button
    @click="goBack"
    class="absolute top-6 left-6 px-4 py-2 bg-zinc-900/90 backdrop-blur-sm text-white rounded-lg border border-zinc-700 hover:bg-zinc-800 hover:border-zinc-600 transition-all duration-200 flex items-center gap-2 text-sm font-medium z-10"
  >
    <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
      <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
    </svg>
    Back
  </button>
</template>
