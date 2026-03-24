<script>
	import DataLayersSidebar from '$lib/components/data-layers/DataLayersSidebar.svelte';
	import GlobeBase from '$lib/components/globe/GlobeBase.svelte';
</script>

<div class="page-container">
	<GlobeBase />
	<DataLayersSidebar />
</div>

<style>
	.page-container {
		display: flex;
		align-items: center;

		height: 100svh;
		width: 100vw;
	}
</style>
