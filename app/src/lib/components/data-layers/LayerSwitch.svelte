<script lang="ts">
	import { Label, Switch } from 'bits-ui';

	let {
		label,
		checked = $bindable(false)
	}: {
		label: string;
		checked?: boolean;
	} = $props();
</script>

<Label.Root>
	{#snippet child({ props })}
		<label class="layer" {...props}>
			<span> {label} </span>
			<Switch.Root bind:checked>
				{#snippet child({ props: rootProps })}
					<button {...rootProps} class="switch-root">
						<Switch.Thumb>
							{#snippet child({ props: thumbProps })}
								<span {...thumbProps} class="switch-thumb"></span>
							{/snippet}
						</Switch.Thumb>
					</button>
				{/snippet}
			</Switch.Root>
		</label>
	{/snippet}
</Label.Root>

<style>
	.layer {
		display: flex;
		justify-content: space-between;
		align-items: center;
		width: 100%;

		font-family: 'Source Code Pro Variable', monospace;
		font-weight: 500;
		text-transform: uppercase;
	}

	.switch-root {
		display: flex;
		align-items: center;

		width: 55px;
		height: 25px;

		padding: 3px;

		background-color: var(--bg-alt);
		border: 1px solid var(--bg);
		border-radius: 4px;

		cursor: pointer;
		transition: background-color 0.2s;
	}

	.switch-root:focus-visible {
		outline: 2px solid white;
	}

	/* Change switch root color when checked */
	.switch-root[data-state='checked'] {
		background-color: var(--primary);
	}

	.switch-thumb {
		display: block;

		width: 25px;
		height: 100%;

		background-color: white;
		border-radius: 2px;

		transition: transform 0.2s cubic-bezier(0.45, 0.05, 0.55, 0.95);
	}

	/* Move switch thumb when checked */
	.switch-root[data-state='checked'] .switch-thumb {
		transform: translateX(22px);
	}
</style>
