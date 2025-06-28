local ts_utils = require('nvim-treesitter.ts_utils')

M = {}

function M.is_async_function()
	local node = ts_utils.get_node_at_cursor()
	while node do
		if node:type() == 'function_definition' then
			local async_node = node:child(0)
			return async_node and async_node:type() == 'async'
		end
		node = node:parent()
	end
	return false
end

local function create_log_snippet(level)
	return s(level, {
		d(1, function(args, snip)
			if M.is_async_function() then
				return sn(nil, {
					t('await logger.'),
					t('a' .. level),
					t('('),
					i(1),
					t(')'),
					i(0),
				})
			else
				return sn(nil, {
					t('logger.'),
					t(level),
					t('('),
					i(1),
					t(')'),
					i(0),
				})
			end
		end),
	})
end

return {
	s('pr', {
		t('print('),
		i(1),
		t(')'),
		i(0),
	}),
	s('init', {
		t('def __init__(self, '),
		i(1),
		t('):'),
		i(0),
	}),

	-- Using treesitter, should look if the function is async, if yes, should add await and use ainfo instead of info
	create_log_snippet('info'),
	create_log_snippet('debug'),
	create_log_snippet('warning'),
	create_log_snippet('error'),
	create_log_snippet('exception'),
	create_log_snippet('critical'),
}
