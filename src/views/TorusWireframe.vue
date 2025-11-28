<script setup>
import { onMounted, ref } from "vue";
import { useRouter } from "vue-router";
import {
  Scene,
  PerspectiveCamera,
  WebGLRenderer,
  TorusGeometry,
  ShaderMaterial,
  Mesh,
  Clock,
  DoubleSide,
} from "three";
import vertexShader from "@/shaders/TorusWireframeVertex.glsl";
import fragmentShader from "@/shaders/TorusWireframeFragment.glsl";

const canvas = ref(null);
const router = useRouter();

const goBack = () => {
  router.push('/');
};

onMounted(() => {
  const scene = new Scene();
  const camera = new PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    0.1,
    1000
  );
  const renderer = new WebGLRenderer();

  renderer.setSize(window.innerWidth, window.innerHeight);
  canvas.value.appendChild(renderer.domElement);

  const clock = new Clock();

  const geometry = new TorusGeometry(1, 0.3, 100, 100);
  const material = new ShaderMaterial({
    uniforms: {
      time: { value: 0.0 },
    },
    vertexShader,
    fragmentShader,
    wireframe: true,
    side: DoubleSide,
  });
  const plane = new Mesh(geometry, material);
  scene.add(plane);

  camera.position.z = 2;

  const animate = function () {
    requestAnimationFrame(animate);
    material.uniforms.time.value = clock.getElapsedTime();
    renderer.render(scene, camera);
  };

  animate();

  window.addEventListener("resize", () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
  });
});
</script>

<template>
  <div class="relative w-full h-screen">
    <div ref="canvas" class="w-full h-full"></div>
    <button
      @click="goBack"
      class="absolute top-6 left-6 px-4 py-2 bg-zinc-900/90 backdrop-blur-sm text-white rounded-lg border border-zinc-700 hover:bg-zinc-800 hover:border-zinc-600 transition-all duration-200 flex items-center gap-2 text-sm font-medium"
    >
      <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
      </svg>
      Back
    </button>
    <div class="absolute bottom-6 left-6 bg-zinc-900/90 backdrop-blur-sm text-white px-5 py-3 rounded-lg border border-zinc-700">
      <h2 class="text-lg font-medium mb-1">Torus Wireframe</h2>
      <p class="text-xs text-zinc-400">Animated shader-based pattern on 3D geometry</p>
    </div>
  </div>
</template>
