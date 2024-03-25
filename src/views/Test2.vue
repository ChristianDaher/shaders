<script setup>
import { onMounted, ref } from "vue";
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
import vertexShader from "@/shaders/Test2VertexShader.glsl";
import fragmentShader from "@/shaders/Test2FragmentShader.glsl";

const canvas = ref(null);

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
  <div ref="canvas"></div>
</template>
