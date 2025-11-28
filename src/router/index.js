import { createRouter, createWebHistory } from "vue-router";
import Home from "@/views/Home.vue";
import WavePattern from "@/views/WavePattern.vue";
import TorusWireframe from "@/views/TorusWireframe.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: Home,
    },
    {
      path: "/wave-pattern",
      name: "WavePattern",
      component: WavePattern,
    },
    {
      path: "/torus-wireframe",
      name: "TorusWireframe",
      component: TorusWireframe,
    },
  ],
});

export default router;
