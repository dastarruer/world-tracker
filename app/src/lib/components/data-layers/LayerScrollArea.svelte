<script lang="ts">
	import type { Snippet } from 'svelte';
	import { ScrollArea } from 'bits-ui';

	let {
		layers
	}: {
		layers: Snippet;
	} = $props();
</script>

<ScrollArea.Root type="hover" class="relative mb-3 flex max-h-[80vh] flex-col overflow-hidden py-3">
	<ScrollArea.Viewport class="h-full w-full">
		<div class="flex flex-col gap-5 p-[15px] [&:last-child]:mb-[-10px]">
			{@render layers()}
		</div>
	</ScrollArea.Viewport>

	<ScrollArea.Scrollbar
		orientation="vertical"
		class="m-1 flex w-[3px] touch-none bg-black/5 transition-colors duration-200 select-none hover:bg-black/10"
	>
		<ScrollArea.Thumb class="relative flex-1 rounded-[10px] bg-[var(--bg-alt)]" />
	</ScrollArea.Scrollbar>
</ScrollArea.Root>
