local lualine = require("lualine")
local python = require("python_resolver")

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diff = {
	"diff",
	colored = false,
	symbols = { added = " ", modified = " ", removed = " " },
	cond = hide_in_width
}

local mode = {
	"mode",
	fmt = function(str)
		return "🪕 " .. str .. " 🪕"
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true
}

local filename = {
	"filename",
	file_status = true,
	path = 0
}

local pyenv = {
	function()
		local path = python.get_pyenv_env_name()
		return "🐍 " .. vim.fn.fnamemodify(path, ":t")
	end,
	cond = function()
		return vim.bo.filetype == "python"
	end
}


local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
}

local diagnostic = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	symbols = {
		error = " ",
		warn = " ",
		info = " ",
		hint = " "
	},
	always_visible = false
}

local progress = {
	"progress",
	fmt = function(str)
		return str .. " / " .. vim.api.nvim_buf_line_count(0)
	end
}


lualine.setup {
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "|", right = "🪕" },
		section_separators = { left = '', right = '' },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = true,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		}
	},
	sections = {
		lualine_a = { branch, diff },
		lualine_b = { mode },
		lualine_c = {},
		lualine_x = { "diagnostic", "encoding", filetype, pyenv },
		lualine_y = { progress },
		lualine_z = { location }
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { location },
		lualine_y = {},
		lualine_z = {}
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {}
}
