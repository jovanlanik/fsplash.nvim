local M = { }
local options = {}
local basename = 'fsplash'
local window = nil
local buffer = nil
local namespace = nil
local default = {
	text = {
		' _  ___   _____ __  __ ';
		'| \\| \\ \\ / /_ _|  \\/  |';
		'| .` |\\ V / | || |\\/| |';
		'|_|\\_| \\_/ |___|_|  |_|';
	};
	autocmds = {
		'ModeChanged';
		'CursorMoved';
		'TextChanged';
		'VimResized';
		'WinScrolled'
	};
	highlights = {
		['NormalFloat'] = {};
	};
	winblend = 0;
	border = 'solid';
}

M.open_window = function()
	if(window ~= nil) then return end

	if(buffer == nil) then
		buffer = vim.api.nvim_create_buf(false, true);
		vim.api.nvim_buf_set_option(buffer, 'modifiable', true)
		vim.api.nvim_buf_set_lines(buffer, 0, -1, false, options.text);
		vim.api.nvim_buf_set_option(buffer, 'modifiable', false)
	end

	if(namespace == nil) then
		namespace = vim.api.nvim_create_namespace(basename);
		for name, val in pairs(options.highlights) do
			vim.api.nvim_set_hl(namespace, name, val)
		end
	end

	local win_config = {
		relative = 'editor';
		width = options.width or #options.text[1];
		height = options.height or  #options.text;
		row = vim.o.lines / 2 - #options.text / 2;
		col = vim.o.columns / 2 - #options.text[1] / 2;
		focusable = false;
		style = options.style or 'minimal';
		border = options.border or 'none';
		noautocmd = true;
	}

	window = vim.api.nvim_open_win(buffer, false, win_config);
	vim.api.nvim_win_set_hl_ns(window, namespace)

	local opts = { group = basename, callback = M.close_window }
	vim.api.nvim_create_augroup(basename, {})
	vim.api.nvim_create_autocmd(options.autocmds, opts)

	vim.wo[window].winblend = options.winblend
end

M.close_window = function()
	vim.api.nvim_clear_autocmds({ group = basename })
	vim.api.nvim_win_close(window, false)
	vim.api.nvim_buf_delete(buffer, {})
	window = nil
end

M.setup = function(opts)
	options = vim.tbl_extend('force', default, opts or {})
end

return M
