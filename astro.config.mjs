// @ts-check
import { defineConfig } from "astro/config";

export default defineConfig({
  server: {
    host: process.env.HOST ?? "0.0.0.0",
    port: parseInt(process.env.PORT || "4321"),
  },
  scopedStyleStrategy: "where",
});
