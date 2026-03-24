<script>
	import DataLayersSidebar from '$lib/components/data-layers/DataLayersSidebar.svelte';
	import GlobeBase from '$lib/components/globe/GlobeBase.svelte';
</script>

<div class="page-container">
	<div class="ui-overlay">
		<DataLayersSidebar />
	</div>

	<div class="globe-wrapper">
		<GlobeBase />
	</div>
</div>

<style>
	.page-container {
		position: relative;
		height: 100svh;
		width: 100vw;
		overflow: hidden;
	}

	.globe-wrapper {
		position: absolute;
		inset: 0; /* Match height and width of parent container (.page-container) */
		z-index: 1;
	}

	.ui-overlay {
		position: absolute;
		z-index: 10;
		inset: 0;

		/* Allow user to click on globe behind the overlay */
		pointer-events: none;

		display: flex;
		align-items: center;
		justify-content: flex-start;

		/* Add space between sidebar and left edge of screen */
		padding-left: 20px;
	}

	/* Re-enables clicking for the actual sidebar buttons */
	.ui-overlay > :global(*) {
		pointer-events: auto;
	}
</style>
