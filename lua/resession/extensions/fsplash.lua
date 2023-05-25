local M = {}

local close_fsplash = function()
	local fsplash = require("fsplash")
	if fsplash.buffer then
		fsplash.close_window()
	end
end

M.on_save = close_fsplash()
M.on_load = close_fsplash()

return M
