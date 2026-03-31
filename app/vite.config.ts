import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig, normalizePath } from 'vite';
import tailwindcss from '@tailwindcss/vite';
import { viteStaticCopy } from 'vite-plugin-static-copy';
import { resolve } from 'path';
import { existsSync, statSync } from 'fs';
import { execFileSync } from 'child_process';

const vitePluginKtx2 = () => {
	return {
		name: 'vite-plugin-ktx2',
		async buildStart() {
			const input = './static/normal-map.png';
			const output = './static/normal-map.ktx2';

			if (existsSync(output)) {
				const inMtime = statSync(input).mtimeMs;
				const outMtime = statSync(output).mtimeMs;
				if (outMtime > inMtime) {
					console.log('ktx2 files are up to date, skipping');
					return;
				}
			}

			console.log('ktx2 files need to be updated, running toktx...');
			try {
				execFileSync(
					'toktx',
					[
						'--t2',
						'--encode',
						'uastc',
						'--uastc_quality',
						'2',
						'--assign_oetf',
						'linear',
						output,
						input
					],
					{ stdio: 'inherit' }
				);
			} catch (e) {
				// Ensure Vite always receives a proper Error object
				throw e instanceof Error ? e : new Error(String(e));
			}
		}
	};
};

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
		}),
		vitePluginKtx2()
	]
});
