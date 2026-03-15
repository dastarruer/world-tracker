<aside>
	<h1>Data Layers</h1>
	<hr />
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

	ul {
		list-style: none;

		display: flex;
		flex-flow: column nowrap;

		height: auto;
		max-height: 80vh;
		overflow-y: auto;

		/* Space between divider and list */
		padding: 12px 0;

		/* Add some spacing between scrollbar and bottom of sidebar */
		margin-bottom: 12px;

		/* Set scrolbar track and scrollbar to transparent */
		scrollbar-color: transparent transparent;
		scrollbar-width: thin;
		scrollbar-gutter: stable;
	}

	aside:hover ul {
		scrollbar-color: rgba(255, 255, 255, 0.15) transparent;
	}

	li {
		padding: 5px 16px;
		margin: 5px;

    font-family: 'Source Code Pro Variable', monospace;
    font-weight: 500;
    text-transform: uppercase;
	}

	li:first-child {
		margin-top: 0;
	}

	li:last-child {
		margin-bottom: 0;
	}
</style>
