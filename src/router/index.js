import { createRouter, createWebHistory } from "vue-router";
import Home from "@/views/Home.vue";
import Test1 from "@/views/Test1.vue";
import Test2 from "@/views/Test2.vue";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: Home,
    },
    {
      path: "/test1",
      name: "Test1",
      component: Test1,
    },
    {
      path: "/test2",
      name: "Test2",
      component: Test2,
    },
  ],
});

export default router;
