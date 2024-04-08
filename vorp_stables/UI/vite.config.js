import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import fs from 'fs';

export default defineConfig({
  plugins: [react(),
    {
      name: 'correct url path', // the name of your custom plugin. Could be anything.
      closeBundle: async () => {
        
        let html = fs.readFileSync("./dist/index.html").toString();
        html = html.replaceAll("/assets", "./assets");
        fs.writeFileSync("./dist/index.html", html);
      }
    },
  ],
})
