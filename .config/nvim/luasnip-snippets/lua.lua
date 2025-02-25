return {
	s('pr', {
		t({ 'Snacks.debug(' }),
		i(1),
		t({ ')' }),
	}),
	s('info', {
		t({ 'Snacks.notifier.notify("' }),
		i(1),
		t({ '", "info", { title = "' }),
		i(2),
		t({ '"})' }),
	}),
}
