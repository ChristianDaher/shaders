<script setup>
import { onMounted, ref } from "vue";
import {
  Scene,
  PerspectiveCamera,
  WebGLRenderer,
  PlaneGeometry,
  ShaderMaterial,
  Mesh,
  Clock,
} from "three";
import vertexShader from "@/shaders/Test1VertexShader.glsl";
import fragmentShader from "@/shaders/Test1FragmentShader.glsl";

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

  const geometry = new PlaneGeometry(7, 7);
  const material = new ShaderMaterial({
    uniforms: {
      time: { value: 0.0 },
    },
    vertexShader,
    fragmentShader,
  });
  const plane = new Mesh(geometry, material);
  scene.add(plane);

  camera.position.z = 5;

  const animate = function () {
    requestAnimationFrame(animate);
    material.uniforms.time.value = clock.getElapsedTime();
    renderer.render(scene, camera);
  };

  animate();
});
</script>

<template>
  <div ref="canvas"></div>
</template>
