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
  Vector2,
  DoubleSide,
} from "three";
import vertexShader from "@/shaders/Test1VertexShader.glsl";
import fragmentShader from "@/shaders/Test1FragmentShader.glsl";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";

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
  <div ref="canvas"></div>
</template>
