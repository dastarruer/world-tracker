<script>
	import DataLayersSidebar from '$lib/components/data-layers/DataLayersSidebar.svelte';
</script>

<div class="page-container">
	<DataLayersSidebar />
</div>

<style>
	:root {
		background-color: var(--bg);

		/* Prevent scrolling if sidebar is too long */
		overflow: hidden;
	}

	.page-container {
		display: flex;
		align-items: center;

		height: 100svh;
		width: 100vw;
	}
</style>
