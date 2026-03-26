<script lang="ts">
	import { T } from '@threlte/core';
	import { OrbitControls, useTexture } from '@threlte/extras';
	import { Texture } from 'three';

	// A larger radius allows for a more detailed normal map, which is important for the visual quality of the globe
	const globeRadius = 12.8;

	let autoRotate = $state(true);

	// Before the map loads, use a low number of segments to make the wireframe have less lines
	let numSegments = $state(20);

	let normalMap = $state<Texture | null>(null);
	let isLoaded = $state(false);

	useTexture('/normal-map.png').then((map) => {
		isLoaded = true;
		normalMap = map;

		setTimeout(() => {
			numSegments = 128;
		}, 100);
	});

	let materialProps = $derived({
		color: '#050505',
		// Use wireframe as a loading state
		wireframe: !isLoaded,
		transparent: !isLoaded,
		opacity: isLoaded ? 1 : 0.3, // Fades the heavy wireframe so it looks better
		normalMap,
		normalScale: [1, 1] as [number, number],
		roughness: isLoaded ? 0.8 : 1,
		metalness: isLoaded ? 0.2 : 0
	});
</script>

<T.PerspectiveCamera
	makeDefault
	position={[globeRadius * 3.5, 0, 0]}
	// No matter where the camera moves, always keep the mesh centered
	oncreate={(ref) => ref.lookAt(0, 0, 0)}
>
	<OrbitControls
		{autoRotate}
		autoRotateSpeed={1}
		enableDamping
		enablePan={false}
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
	<T.AmbientLight color="#b9d5ff" intensity={2} />
</T.PerspectiveCamera>

<T.Mesh>
	<T.SphereGeometry args={[globeRadius, numSegments, numSegments]} />
	<T.MeshStandardMaterial {...materialProps} />
</T.Mesh>
