<script lang="ts">
	import { T } from '@threlte/core';
	import { OrbitControls, useTexture } from '@threlte/extras';

	// A larger radius allows for a more detailed normal map, which is important for the visual quality of the globe
	const globeRadius = 128;

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
</T.PerspectiveCamera>

<T.DirectionalLight
	position={[50, 10, 50]}
	intensity={3}
	oncreate={(ref) => {
		// Point the light exactly at the center of the globe
		ref.lookAt(0, 0, 0);
	}}
/><T.AmbientLight intensity={0.2} color="#b9d5ff" />

{#await normalMap then value}
	<T.Mesh>
		<T.SphereGeometry args={[globeRadius, 300, 300]} />
		<T.MeshStandardMaterial
			color="grey"
			normalMap={value}
			normalScale={[1, 1]}
			roughness={0.5}
			metalness={0.1}
		/>
	</T.Mesh>
{/await}
