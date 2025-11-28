<script setup>
import { onMounted, ref } from "vue";
import { useRouter } from "vue-router";
import {
  Scene,
  PerspectiveCamera,
  WebGLRenderer,
  PlaneGeometry,
  ShaderMaterial,
  Mesh,
  Clock,
  Vector2,
  DoubleSide,
} from "three";
import vertexShader from "@/shaders/WavePatternVertex.glsl";
import fragmentShader from "@/shaders/WavePatternFragment.glsl";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";

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

  const controls = new OrbitControls(camera, renderer.domElement);

  const clock = new Clock();

  const geometry = new PlaneGeometry(3, 3);
  const material = new ShaderMaterial({
    uniforms: {
      time: { value: 0.0 },
      resolution: { value: new Vector2(window.innerWidth, window.innerHeight) },
    },
    vertexShader,
    fragmentShader,
    side: DoubleSide,
  });
  const plane = new Mesh(geometry, material);
  scene.add(plane);

  camera.position.z = 1;

  const animate = function () {
    requestAnimationFrame(animate);
    controls.update();
    material.uniforms.time.value = clock.getElapsedTime() / 1.5;
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
      class="absolute top-8 left-8 px-6 py-3 bg-gray-900/80 backdrop-blur-sm text-white rounded-lg border border-gray-700/50 hover:bg-purple-600/80 hover:border-purple-500/50 transition-all duration-300 flex items-center gap-2 font-semibold shadow-lg hover:shadow-purple-500/20"
    >
      <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18" />
      </svg>
      Back to Gallery
    </button>
    <div class="absolute bottom-8 left-8 bg-gray-900/80 backdrop-blur-sm text-white px-6 py-4 rounded-lg border border-gray-700/50 shadow-lg">
      <h2 class="text-xl font-bold mb-1">Animated Wave Pattern</h2>
      <p class="text-sm text-gray-300">Click and drag to rotate • Scroll to zoom</p>
    </div>
  </div>
</template>
