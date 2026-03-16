<script lang="ts">
	import { Separator } from 'bits-ui';
</script>

<Separator.Root decorative={true}>
	{#snippet child({ props })}
		<div class="separator" {...props}></div>
	{/snippet}
</Separator.Root>

<style>
	.separator {
		/* Remove default border */
		border: 0;
		height: 1px;
		background-color: var(--text);
		opacity: 0.1;
		width: 370px;
		align-self: center;
	}
</style>
