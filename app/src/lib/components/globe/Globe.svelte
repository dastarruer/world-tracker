<script lang="ts">
	import { T } from '@threlte/core';
	import { OrbitControls } from '@threlte/extras';

	const globeRadius = 2;

	let autoRotate = $state(true);
</script>

<T.PerspectiveCamera
	makeDefault
	position={[7, 0, 0]}
	// No matter where the camera moves, always keep the mesh centered
	oncreate={(ref) => ref.lookAt(0, 0, 0)}
>
	<OrbitControls
		{autoRotate}
		autoRotateSpeed={1}
		enableDamping
		enablePan={false}
		maxDistance={10}
		minDistance={globeRadius + 0.1}
		onstart={() => (autoRotate = false)}
	/>
</T.PerspectiveCamera>

<T.DirectionalLight position={[10, 20, -25]} intensity={25} castShadow />
<T.AmbientLight color="#d6efff" />

<T.Mesh>
	<T.SphereGeometry args={[globeRadius, 32, 32]} />
	<T.MeshStandardMaterial color="grey" />
</T.Mesh>
