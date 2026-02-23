// @ts-check
import { defineConfig } from "astro/config";
import sitemap from "@astrojs/sitemap";
import robotsTxt from "astro-robots-txt";
import llmsTxtIntegration from "astro-llms-txt-generator";

export default defineConfig({
  site: "https://shreecreatixagency.com",
  integrations: [sitemap(), robotsTxt(), llmsTxtIntegration()],
  server: {
    host: process.env.HOST ?? "0.0.0.0",
    port: parseInt(process.env.PORT || "4321"),
  },
  scopedStyleStrategy: "where",
});
