<script lang="ts">
	import LayerSwitch from './LayerSwitch.svelte';
	import LayerScrollArea from './LayerScrollArea.svelte';
</script>

<aside>
	<h1>Data Layers</h1>
	<hr />
	<LayerScrollArea>
		{#snippet layers()}
			<!-- Here for testing purposes as of now; will be removed later -->
			{#each Array(50) as _, i}
				<LayerSwitch label="Satellites" />
			{/each}
		{/snippet}
	</LayerScrollArea>
</aside>

<style>
	aside {
		display: flex;
		flex-direction: column;

		width: 400px;

		border: 1px solid var(--bg-alt);
		border-radius: 10px;

		background-color: var(--bg);
		color: var(--text);
	}

	h1 {
		font-family: 'Orbitron Variable', sans-serif;
		font-size: 1.5rem;
		text-transform: uppercase;

		padding: 16px 20px 0px 20px;
		margin: 0;
	}

	hr {
		/* Remove default border */
		border: 0;
		height: 1px;
		background-color: var(--text);
		opacity: 0.1;
		width: 370px;
		align-self: center;
	}
</style>
