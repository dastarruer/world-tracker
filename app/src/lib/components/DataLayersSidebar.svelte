<aside>
	<h1>Data Layers</h1>
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

		border-radius: 10px;

		background-color: var(--bg-alt);
		color: var(--text);
	}

  h1 {
    font-size: 1.7rem;
    margin-left: 12px;
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
