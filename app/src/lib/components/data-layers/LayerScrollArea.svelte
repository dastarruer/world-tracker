<script lang="ts">
	import type { Snippet } from 'svelte';
	import { ScrollArea } from 'bits-ui';

	let {
		layers
	}: {
		layers: Snippet;
	} = $props();
</script>

<ScrollArea.Root type="hover">
	{#snippet child({ props })}
		<div class="scroll-root" {...props}>
			<ScrollArea.Viewport class="viewport">
				{#snippet children()}
					<div class="list-container">
						{@render layers()}
					</div>
				{/snippet}
			</ScrollArea.Viewport>
			<ScrollArea.Scrollbar orientation="vertical">
				{#snippet child({ props: scrollRootProps })}
					<div class="scrollbar-root" {...scrollRootProps}>
						<ScrollArea.Thumb>
							{#snippet child({ props: scrollThumbProps })}
								<div class="scrollbar-thumb" {...scrollThumbProps}></div>
							{/snippet}
						</ScrollArea.Thumb>
					</div>
				{/snippet}
			</ScrollArea.Scrollbar>
		</div>
	{/snippet}
</ScrollArea.Root>

<style>
	.scroll-root {
		height: auto;
		max-height: 80vh;

		display: flex;
		flex-direction: column;
		overflow: hidden;
		padding: 12px 0;
		margin-bottom: 12px;
	}

	.scrollbar-root {
		width: 3px;
		background: rgba(0, 0, 0, 0.05);
		margin: 4px;
		transition: background 0.2s;
	}

	.scrollbar-thumb {
		flex: 1;
		background: var(--bg-alt);
		border-radius: 10px;
		position: relative;
	}

	.list-container {
		list-style: none;
		display: flex;
		gap: 20px;
		flex-flow: column nowrap;
		margin: 0;
		padding: 15px;
	}

	.list-container:last-child {
		margin-bottom: -10px;
	}
</style>
