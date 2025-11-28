<script setup>
import { onMounted, onUnmounted, ref } from "vue";
import {
  Scene,
  PerspectiveCamera,
  WebGLRenderer,
  ShaderMaterial,
  Mesh,
  Clock,
  DoubleSide,
} from "three";
import { OrbitControls } from "three/examples/jsm/controls/OrbitControls";

const props = defineProps({
  geometry: {
    type: Object,
    required: true
  },
  vertexShader: {
    type: String,
    required: true
  },
  fragmentShader: {
    type: String,
    required: true
  },
  uniforms: {
    type: Object,
    default: () => ({})
  },
  cameraPosition: {
    type: Object,
    default: () => ({ x: 0, y: 0, z: 1 })
  },
  enableControls: {
    type: Boolean,
    default: false
  },
  wireframe: {
    type: Boolean,
    default: false
  },
  timeScale: {
    type: Number,
    default: 1
  },
  fitToScreen: {
    type: Boolean,
    default: false
  }
});

const canvas = ref(null);
let animationId = null;
let renderer = null;
let mesh = null;

onMounted(() => {
  const scene = new Scene();
  const camera = new PerspectiveCamera(
    75,
    window.innerWidth / window.innerHeight,
    0.1,
    1000
  );
  renderer = new WebGLRenderer({ antialias: true });

  renderer.setSize(window.innerWidth, window.innerHeight);
  canvas.value.appendChild(renderer.domElement);

  let controls = null;
  if (props.enableControls) {
    controls = new OrbitControls(camera, renderer.domElement);
    controls.enableDamping = true;
    controls.dampingFactor = 0.05;
  }

  const clock = new Clock();

  const material = new ShaderMaterial({
    uniforms: {
      time: { value: 0.0 },
      ...props.uniforms
    },
    vertexShader: props.vertexShader,
    fragmentShader: props.fragmentShader,
    wireframe: props.wireframe,
    side: DoubleSide,
  });

  mesh = new Mesh(props.geometry, material);
  scene.add(mesh);

  camera.position.set(props.cameraPosition.x, props.cameraPosition.y, props.cameraPosition.z);

  // Function to scale plane to fit screen
  const updatePlaneScale = () => {
    if (props.fitToScreen && mesh && mesh.geometry.type === 'PlaneGeometry') {
      const aspect = window.innerWidth / window.innerHeight;
      const distance = camera.position.z;
      const vFov = camera.fov * Math.PI / 180;
      const planeHeightAtDistance = 2 * Math.tan(vFov / 2) * distance;
      const planeWidthAtDistance = planeHeightAtDistance * aspect;
      
      // Scale uniformly to cover the screen based on the larger dimension
      const scale = Math.max(planeWidthAtDistance / 3, planeHeightAtDistance / 3);
      mesh.scale.set(scale, scale, 1);
    }
  };

  updatePlaneScale();

  const animate = function () {
    animationId = requestAnimationFrame(animate);
    if (controls) controls.update();
    material.uniforms.time.value = clock.getElapsedTime() / props.timeScale;
    renderer.render(scene, camera);
  };

  animate();

  const handleResize = () => {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
    updatePlaneScale();
  };

  window.addEventListener("resize", handleResize);

  onUnmounted(() => {
    window.removeEventListener("resize", handleResize);
    if (animationId) cancelAnimationFrame(animationId);
    if (renderer) renderer.dispose();
  });
});
</script>

<template>
  <div ref="canvas" class="w-full h-full"></div>
</template>
