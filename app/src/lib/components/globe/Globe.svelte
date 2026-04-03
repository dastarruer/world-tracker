<script lang="ts">
	import { T, useThrelte } from '@threlte/core';
	import { OrbitControls, useKtx2 } from '@threlte/extras';
	import { untrack } from 'svelte';
	import { PerspectiveCamera, Texture } from 'three';

	const globeRadius = 12.8;

	let autoRotate = $state(true);

	let zoom = $state(1);
	let fov = $derived(50 * 2);

	const { camera } = useThrelte();

	$effect(() => {
		if (!($camera instanceof PerspectiveCamera)) return;

		// Declare fov here so the effect reruns when fov changes
		const currentFov = fov;

		// Putting $camera in this method will not rerun the effect when they
		// change.
		// Otherwise, everytime the camera changes, the effect will rerun,
		// causing infinite loops.
		untrack(() => {
			const cam = $camera as PerspectiveCamera;
			cam.fov = currentFov;
			cam.updateProjectionMatrix();
			console.log('Camera FOV updated:', fov);
		});
	});

	// Before the map loads, use a low number of segments to make the wireframe have less lines
	let numSegments = $state(20);

	let normalMap = $state<Texture | null>(null);
	let isLoaded = $state(false);

	// Transcoder files are copied at build time in vite.config.ts
	useKtx2('/basis/')
		.loadAsync('/normal-map.ktx2')
		.then((map: Texture) => {
			isLoaded = true;
			normalMap = map;

			// Then use a higher number of segments to make the globe look smoother
			numSegments = 128;
		});

	let materialProps = $derived({
		color: '#050505',
		// Use wireframe as a loading state
		wireframe: !isLoaded,
		transparent: !isLoaded,
		opacity: isLoaded ? 1 : 0.3, // Fades the heavy wireframe so it looks better
		normalMap,
		normalScale: [1.5, 1.5] as [number, number],
		roughness: isLoaded ? 0.8 : 1,
		metalness: isLoaded ? 0.2 : 0
	});
</script>

<T.PerspectiveCamera
	makeDefault
	{zoom}
	position={[globeRadius * 3.5, 0, 0]}
	// No matter where the camera moves, always keep the mesh centered
	oncreate={(ref) => ref.lookAt(0, 0, 0)}
>
	<OrbitControls
		{autoRotate}
		autoRotateSpeed={1}
		enableDamping
		enablePan={false}
		// Disable rotation while loading to further indicate that the globe isn't ready yet
		enableRotate={isLoaded}
		maxDistance={globeRadius * 5}
		minDistance={globeRadius + 0.1}
		onstart={() => (autoRotate = false)}
	/>
	<T.DirectionalLight
		position={[globeRadius * 4, globeRadius * 2, globeRadius * 2]}
		intensity={2}
	/>
	<T.DirectionalLight
		position={[-globeRadius * 4, globeRadius * 2, globeRadius * 2]}
		intensity={2}
	/>
	<T.DirectionalLight
		position={[globeRadius * 4, -globeRadius * 2, globeRadius * 2]}
		intensity={2}
	/>
</T.PerspectiveCamera>

<!-- Flip the sphere so that the normal map is right side up -->
<T.Mesh scale={[1, -1, 1]}>
	<T.SphereGeometry args={[globeRadius, numSegments, numSegments]} />
	<T.MeshStandardMaterial {...materialProps} />
</T.Mesh>
