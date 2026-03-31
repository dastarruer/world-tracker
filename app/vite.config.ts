import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig, normalizePath } from 'vite';
import tailwindcss from '@tailwindcss/vite';
import { viteStaticCopy } from 'vite-plugin-static-copy';
import { resolve } from 'path';

export default defineConfig({
	plugins: [
		sveltekit(),
		tailwindcss(),
		// Copy transcoder files at build time
		// This is necessary to load ktx2 files in the browser
		viteStaticCopy({
			targets: [
				{
					src: normalizePath(resolve(__dirname, 'node_modules/three/examples/jsm/libs/basis')),
					dest: '',
					// Strip node_modules/three/examples/jsm/libs/
					rename: { stripBase: 5 }
				}
			]
		})
	]
});
