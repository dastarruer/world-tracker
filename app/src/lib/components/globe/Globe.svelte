<script lang="ts">
	import { T } from '@threlte/core';
	import { OrbitControls, useTexture } from '@threlte/extras';
	import { Vector2 } from 'three';

	// A larger radius allows for a more detailed normal map, which is important for the visual quality of the globe
	const globeRadius = 12.8;

	let autoRotate = $state(true);

	const normalMap = useTexture('/normal-map.png');
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

{#await normalMap then normalMap}
	<T.Mesh>
		<T.SphereGeometry args={[globeRadius, 450, 450]} />
		<T.MeshStandardMaterial
			color="#050505"
			roughness={0.8}
			metalness={0.2}
			{normalMap}
			normalScale={[2, 2]}
		/>
	</T.Mesh>
{/await}
