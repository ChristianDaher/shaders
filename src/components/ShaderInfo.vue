<script setup>
defineProps({
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  }
});
</script>

<template>
  <div class="absolute bottom-6 left-6 bg-zinc-900/90 backdrop-blur-sm text-white px-5 py-3 rounded-lg border border-zinc-700 z-10">
    <h2 class="text-lg font-medium mb-1">{{ title }}</h2>
    <p class="text-xs text-zinc-400">{{ description }}</p>
  </div>
</template>
