<script lang="ts">
	import { T, useThrelte } from '@threlte/core';
	import { untrack, type Snippet } from 'svelte';
	import { PerspectiveCamera } from 'three';

	interface Props {
		position: [number, number, number];
		children?: Snippet;
	}

	let { position, children }: Props = $props();

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
</script>

<T.PerspectiveCamera
	makeDefault
	{zoom}
	{position}
	// No matter where the camera moves, always look at the center of the scene
	oncreate={(ref: PerspectiveCamera) => ref.lookAt(0, 0, 0)}
>
	{@render children?.()}
</T.PerspectiveCamera>
