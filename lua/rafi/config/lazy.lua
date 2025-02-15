-- Rafi's lazy.nvim initialization
-- https://github.com/rafi/vim-config

-- Clone lazy.nvim if not already installed.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
	print('Installing lazy.nvim…')
	-- stylua: ignore
	vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Load user options from lua/config/setup.lua
local user_lazy_opts = {}
local ok, user_setup = pcall(require, 'config.setup')
if ok and user_setup.lazy_opts then
	user_lazy_opts = user_setup.lazy_opts() or {}
end

-- Validate if lua/plugins/ or lua/plugins.lua exist.
local user_path = vim.fn.stdpath('config') .. '/lua'
local has_user_plugins = vim.uv.fs_stat(user_path .. '/plugins') ~= nil
	or vim.uv.fs_stat(user_path .. '/plugins.lua') ~= nil

-- Overload rafi.config after $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/config/options.lua
-- TODO: Try preload 'lazyvim.config.options' and return my options, instead.
vim.api.nvim_create_autocmd('User', {
	group = vim.api.nvim_create_augroup('rafi_options', { clear = true }),
	pattern = 'LazyVimOptionsDefaults',
	callback = function()
		require('rafi.config').setup()
	end,
})

-- Start lazy.nvim plugin manager.
require('lazy').setup(vim.tbl_extend('keep', user_lazy_opts, {
	spec = {
		-- LazyVim framework.
		{
			'LazyVim/LazyVim',
			version = '*',
			priority = 10000,
			lazy = false,
			cond = true,
			import = 'lazyvim.plugins',
			---@type LazyVimOptions
			opts = {
				colorscheme = function() end,
				-- stylua: ignore
				icons = {
					misc = {
						git = ' ',
					},
					status = {
						git = {
							added    = '₊', --  ₊
							modified = '∗', --  ∗
							removed  = '₋', --  ₋
						},
						diagnostics = {
							error = ' ',
							warn  = ' ',
							info  = ' ',
							hint  = ' ',
						},
						filename = {
							modified = '+',
							readonly = '🔒',
							zoomed   = '🔎',
						},
					},
					-- Default completion kind symbols.
					kinds = {
						Array         = '󰅪 ', --  󰅪 󰅨 󱃶
						Boolean       = '󰨙 ', -- 󰨙 󰔡 󱃙 󰟡  ◩
						Class         = '󰌗 ', --  󰌗 󰠱 𝓒
						Codeium       = '󰘦 ',
						Collapsed     = ' ',
						Color         = '󰏘 ', --  󰸌 󰏘
						Constant      = '󰏿 ', -- 󰏿  
						Constructor   = ' ', --   
						Control       = ' ',
						Copilot       = ' ',
						Enum          = '󰕘 ', --   󰕘 ℰ 
						EnumMember    = ' ',
						Event         = ' ', --  
						Field         = ' ', --  󰄶  󰆨  󰀻 󰃒 
						File          = ' ', --    󰈔 󰈙
						Folder        = ' ', --   󰉋
						Function      = '󰊕 ', -- 󰊕 ƒ 
						Interface     = ' ', --    
						Key           = ' ',
						Keyword       = ' ', --   󰌋 
						Method        = '󰊕 ',
						Module        = ' ',
						Namespace     = '󰦮 ',
						Null          = ' ', --  󰟢
						Number        = '󰎠 ', -- 󰎠  
						Object        = ' ', --   󰅩
						Operator      = '󰃬 ', --  󰃬 󰆕 +
						Package       = ' ', --   󰏖 󰏗 󰆧 
						Property      = ' ', --    󰖷
						Reference     = '󰈝 ', --  󰈝 󰈇
						Snippet       = '󱄽 ', -- 󱄽   󰘌 ⮡  
						String        = ' ', --   󰅳
						Struct        = '󰆼 ', -- 󰆼   𝓢 󰙅 󱏒
						Supermaven    = ' ',
						TabNine       = '󰏚 ',
						Text          = ' ', --   󰉿 𝓐
						TypeParameter = ' ', --  󰊄 𝙏
						Unit          = ' ', --   󰑭 
						Value         = ' ', --  󰀬 󰎠 
						Variable      = ' ', -- 󰀫  
					},
				},
			},
		},
		{ import = 'rafi.plugins' },
		has_user_plugins and { import = 'plugins' } or nil,
	},
	defaults = { lazy = true, version = false },
	dev = { path = vim.fn.stdpath('config') .. '/dev' },
	install = { missing = true, colorscheme = {} },
	checker = { enabled = true, notify = false },
	change_detection = { notify = false },
	ui = {
		size = { width = 0.8, height = 0.85 },
		border = 'rounded',
		wrap = false,
	},
	diff = { cmd = 'terminal_git' },
	performance = {
		rtp = {
			disabled_plugins = {
				'gzip',
				'vimballPlugin',
				'matchit',
				'matchparen',
				'2html_plugin',
				'tohtml',
				'tarPlugin',
				'netrwPlugin',
				'tutor',
				'zipPlugin',
			},
		},
	},
}))

-- Enjoy!
