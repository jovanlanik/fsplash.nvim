local pkg_name = 'fsplash'
local M = {}

M.opt = {}
M.window = nil
M.buffer = nil
M.namespace = nil

local default = {
	lines = {
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
		'WinScrolled';
	};
	highlights = {
		['NormalFloat'] = {};
	};
	border = 'solid';
	winblend = 0;
}

M.open_window = function()
	if(M.window ~= nil) then return end

	if(M.buffer == nil) then
		M.buffer = vim.api.nvim_create_buf(false, true);
		vim.api.nvim_buf_set_option(M.buffer, 'modifiable', true)
		vim.api.nvim_buf_set_lines(M.buffer, 0, -1, false, M.opt.lines);
		vim.api.nvim_buf_set_option(M.buffer, 'modifiable', false)
	end

	if(M.namespace == nil) then
		M.namespace = vim.api.nvim_create_namespace(pkg_name);
		for name, val in pairs(M.opt.highlights) do
			vim.api.nvim_set_hl(M.namespace, name, val)
		end
	end

	local win_config = {
		relative = 'editor';
		width = M.opt.width or #M.opt.lines[1];
		height = M.opt.height or  #M.opt.lines;
		row = vim.o.lines / 2 - #M.opt.lines / 2;
		col = vim.o.columns / 2 - #M.opt.lines[1] / 2;
		focusable = false;
		style = 'minimal';
		border = M.opt.border;
		noautocmd = true;
	}

	M.window = vim.api.nvim_open_win(M.buffer, false, win_config);
	vim.api.nvim_win_set_hl_ns(M.window, M.namespace)

	local opts = { group = pkg_name, callback = M.close_window }
	vim.api.nvim_create_augroup(pkg_name, {})
	vim.api.nvim_create_autocmd(M.opt.autocmds, opts)

	vim.wo[M.window].winblend = M.opt.winblend
end

M.close_window = function()
	vim.api.nvim_clear_autocmds({ group = pkg_name })
	vim.api.nvim_win_close(M.window, false)
	vim.api.nvim_buf_delete(M.buffer, {})
	M.window = nil
	M.buffer = nil
end

M.setup = function(opts)
	M.opt = vim.tbl_extend('force', default, opts or {})
end

return M
