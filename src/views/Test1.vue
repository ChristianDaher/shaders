<script setup>
import { onMounted, ref } from "vue";
import {
  Scene,
  PerspectiveCamera,
  WebGLRenderer,
  BoxGeometry,
  ShaderMaterial,
  Mesh,
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

  const geometry = new BoxGeometry();
  const material = new ShaderMaterial({
    vertexShader,
    fragmentShader,
  });
  const cube = new Mesh(geometry, material);
  scene.add(cube);

  camera.position.z = 5;

  const animate = function () {
    requestAnimationFrame(animate);
    cube.rotation.x += 0.01;
    cube.rotation.y += 0.01;
    renderer.render(scene, camera);
  };

  animate();
});
</script>

<template>
  <div ref="canvas"></div>
</template>
