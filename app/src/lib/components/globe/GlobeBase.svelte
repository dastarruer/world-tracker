<script lang="ts">
	import { Canvas } from '@threlte/core';
	import Globe from './Globe.svelte';
</script>

<!-- div tag is necessary; otherwise nothing will show up -->
<div>
	<Canvas>
		<Globe />
	</Canvas>
</div>

<style>
	div {
		background-color: black;
		height: 100%;
	}
</style>
