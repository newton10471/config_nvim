-- vim.cmd("colorscheme rose-pine")
vim.wo.number = true
vim.opt["tabstop"] = 2
vim.opt["shiftwidth"] = 2
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    {
    	'nvim-telescope/telescope.nvim', tag = '0.1.8',
      	dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
			"tpope/vim-fugitive",
		},
		{ 
			"rose-pine/neovim", name = "rose-pine"
		},
		{
			'barrett-ruth/live-server.nvim',
			build = 'npm i -g live-server',
			cmd = { 'LiveServerStart', 'LiveServerStop' },
			config = true
		}
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

local builtin = require("telescope.builtin")
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
