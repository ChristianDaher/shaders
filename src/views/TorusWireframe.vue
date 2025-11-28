<script setup>
import { TorusGeometry } from "three";
import ShaderCanvas from "@/components/ShaderCanvas.vue";
import BackButton from "@/components/BackButton.vue";
import ShaderInfo from "@/components/ShaderInfo.vue";
import vertexShader from "@/shaders/TorusWireframeVertex.glsl";
import fragmentShader from "@/shaders/TorusWireframeFragment.glsl";

const geometry = new TorusGeometry(1, 0.3, 100, 100);
</script>

<template>
  <div class="relative w-full h-screen">
    <ShaderCanvas 
      :geometry="geometry"
      :vertex-shader="vertexShader"
      :fragment-shader="fragmentShader"
      :camera-position="{ x: 0, y: 0, z: 2 }"
      :enable-controls="true"
      :wireframe="true"
      :time-scale="1"
    />
    <BackButton />
    <ShaderInfo 
      title="Torus Wireframe"
      description="Click and drag to rotate • Scroll to zoom"
    />
  </div>
</template>
