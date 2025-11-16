return {
	'chrisgrieser/nvim-recorder',
	dependencies = 'rcarriga/nvim-notify', -- optional
	opts = {
		mapping = {
			startStopRecording = '<A-q>',
			playMacro = 'Q',
			switchSlot = '<C-q>',
			editMacro = 'cq',
			deleteAllMacros = 'dq',
			yankMacro = 'yq',
		},
	}, -- required even with default settings, since it calls `setup()`
}
