import { sveltekit } from '@sveltejs/kit/vite';
import { defineConfig, normalizePath } from 'vite';
import tailwindcss from '@tailwindcss/vite';
import { viteStaticCopy } from 'vite-plugin-static-copy';
import { resolve } from 'path';
import { existsSync, statSync, readFileSync, writeFileSync } from 'fs';
import sharp from 'sharp';
import { encodeToKTX2 } from 'ktx2-encoder';

const vitePluginKtx2 = () => {
	return {
		name: 'vite-plugin-ktx2',
		async buildStart() {
			const pngImg = './static/normal-map.png';
			const ktx2Img = './static/normal-map.ktx2';

			// Check if png needs to be reencoded
			if (existsSync(ktx2Img) && existsSync(pngImg)) {
				const inMtime = statSync(pngImg).mtimeMs;
				const outMtime = statSync(ktx2Img).mtimeMs;
				if (outMtime > inMtime) {
					console.log('ktx2 files are up to date, skipping');
					return;
				}
			}

			console.log('ktx2 encoding PNG to KTX2...');
			try {
				const pngBuffer = readFileSync(pngImg);

				const ktx2Buffer = await encodeToKTX2(pngBuffer, {
					// Since this is being run w nodejs and not a browser, we need to provide our own decoder
					imageDecoder: async (data) => {
						const { data: rawPixels, info } = await sharp(data)
							.ensureAlpha()
							.raw()
							.toBuffer({ resolveWithObject: true });

						return {
							data: new Uint8Array(rawPixels),
							width: info.width,
							height: info.height
						};
					},
					isUASTC: true,
					qualityLevel: 2,
					isNormalMap: true,
					generateMipmap: true, // Use since image is a normal map
					isKTX2File: true,
					needSupercompression: true
				});

				// Write the result
				writeFileSync(ktx2Img, Buffer.from(ktx2Buffer));
				console.log(`ktx2 successfully created ${ktx2Img}`);
			} catch (e) {
				console.error('ktx2 conversion failed:');
				throw e instanceof Error ? e : new Error(String(e));
			}
		}
	};
};

export default defineConfig({
	plugins: [
		sveltekit(),
		tailwindcss(),
		viteStaticCopy({
			targets: [
				{
					src: normalizePath(resolve(__dirname, 'node_modules/three/examples/jsm/libs/basis')),
					dest: '',
					rename: { stripBase: 5 }
				}
			]
		}),
		vitePluginKtx2()
	]
});
