<script setup>
import { PlaneGeometry } from "three";
import ShaderCanvas from "@/components/ShaderCanvas.vue";
import BackButton from "@/components/BackButton.vue";
import ShaderInfo from "@/components/ShaderInfo.vue";
import vertexShader from "@/shaders/WavePatternVertex.glsl";
import fragmentShader from "@/shaders/WavePatternFragment.glsl";

const geometry = new PlaneGeometry(3, 3);
</script>

<template>
  <div class="relative w-full h-screen">
    <ShaderCanvas 
      :geometry="geometry"
      :vertex-shader="vertexShader"
      :fragment-shader="fragmentShader"
      :camera-position="{ x: 0, y: 0, z: 1 }"
      :enable-controls="false"
      :time-scale="1.5"
      :fit-to-screen="true"
    />
    <BackButton />
    <ShaderInfo 
      title="Animated Wave Pattern"
      description="Procedural fractal shader art"
    />
  </div>
</template>
