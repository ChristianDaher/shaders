<script setup>
import { RouterLink } from 'vue-router'

const shaders = [
  {
    name: 'Animated Wave Pattern',
    path: '/wave-pattern',
    description: 'Fractal wave pattern with dynamic color palette using procedural generation.',
    tags: ['Procedural', 'Fractals', 'Animation']
  },
  {
    name: 'Torus Wireframe',
    path: '/torus-wireframe',
    description: 'Interactive 3D torus geometry with custom shader-based pattern rendering.',
    tags: ['3D Geometry', 'Wireframe', 'Interactive']
  }
]
</script>

<template>
  <main class="min-h-screen bg-zinc-950">
    <div class="container mx-auto px-6 py-20 max-w-5xl">
      <!-- Header -->
      <header class="mb-20">
        <h1 class="text-4xl md:text-5xl font-semibold text-white mb-3">
          WebGL Shader Demos
        </h1>
        <p class="text-lg text-zinc-400">
          Interactive shader experiments with Three.js and Vue 3
        </p>
      </header>

      <!-- Shader Grid -->
      <div class="space-y-4">
        <RouterLink
          v-for="shader in shaders"
          :key="shader.path"
          :to="shader.path"
          class="group block bg-zinc-900 rounded-lg p-6 border border-zinc-800 hover:border-zinc-600 hover:bg-zinc-900/80 transition-all duration-200"
        >
          <div class="flex items-start justify-between">
            <div class="flex-1">
              <h2 class="text-xl font-medium text-white mb-2">
                {{ shader.name }}
              </h2>
              <p class="text-zinc-400 mb-3 text-sm">
                {{ shader.description }}
              </p>
              <div class="flex flex-wrap gap-2">
                <span
                  v-for="tag in shader.tags"
                  :key="tag"
                  class="px-2.5 py-0.5 text-xs font-medium bg-zinc-800 text-zinc-300 rounded"
                >
                  {{ tag }}
                </span>
              </div>
            </div>
            <svg class="w-5 h-5 ml-4 text-zinc-600 group-hover:text-zinc-400 group-hover:translate-x-1 transition-all flex-shrink-0 mt-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
            </svg>
          </div>
        </RouterLink>
      </div>

      <!-- Footer -->
      <footer class="mt-20 pt-8 border-t border-zinc-800">
        <p class="text-sm text-zinc-500">
          Built with Vue 3, Three.js, and WebGL · 
          <a href="https://github.com/ChristianDaher/shaders" target="_blank" rel="noopener noreferrer" class="text-zinc-400 hover:text-white underline underline-offset-2">
            View Source
          </a>
        </p>
      </footer>
    </div>
  </main>
</template>
