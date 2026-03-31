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

<Label.Root
	class="flex w-full items-center justify-between font-mono font-medium tracking-wider uppercase"
>
	<span>{label}</span>
	<Switch.Root
		bind:checked
		class="box-border flex h-6 w-14 cursor-pointer items-center rounded bg-(--bg-alt) p-1 transition-colors duration-200 focus-visible:outline focus-visible:outline-white data-[state=checked]:bg-(--primary)"
	>
		<Switch.Thumb
			class="block h-full w-6 rounded-sm bg-white transition-transform duration-200 ease-in-out data-[state=checked]:translate-x-6"
		/>
	</Switch.Root>
</Label.Root>
