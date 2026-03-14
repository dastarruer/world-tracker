<aside>
	<h2>Data Layers</h2>
	<ul>
		<!-- Here for testing purposes as of now; will be removed later -->
		{#each Array(50) as _, i}
			<li>
				<label>
					<input type="checkbox" name="layer" value="planes" checked />
					Satellites
				</label>
			</li>
		{/each}
	</ul>
</aside>

<style>
	aside {
		width: 400px;

		background-color: var(--bg-alt);
		color: var(--text);
	}

	ul {
		display: flex;
		flex-flow: column nowrap;

		height: auto;
		max-height: 80vh;
		overflow-y: auto;
	}

	li {
		padding: 5px;
		margin: 5px;
	}
</style>
