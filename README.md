# fsplash.nvim (floating splash screen)
Show a custom splash screen in a floating window.

![screenshot](https://github.com/jovanlanik/fsplash.nvim/assets/21199271/2e732304-83f5-4217-a4aa-a9e59d82b420)
## Install
First install using your favorite package manager:
- packer.nvim: `use 'jovanlanik/fsplash'`
- paq-nvim: `'jovanlanik/fsplash'`
- lazy.nvim: `'jovanlanik/fsplash'`
- vim-plug: `Plug 'jovanlanik'`
Then setup fsplash in your config:
```lua
require('fsplash').setup()
```
## Configure
The setup function accepts the following options:
```lua
require('fsplash').setup(
    -- lines of text containing the splash
	lines = {
		' _  ___   _____ __  __ ';
		'| \\| \\ \\ / /_ _|  \\/  |';
		'| .` |\\ V / | || |\\/| |';
		'|_|\\_| \\_/ |___|_|  |_|';
	};
    -- autocmds that close the splash
	autocmds = {
		'ModeChanged';
		'CursorMoved';
		'TextChanged';
		'VimResized';
		'WinScrolled';
	};
    -- highlights in this table will be set using vim.api.nvim_set_hl()
	highlights = {
        -- this resets NormalFloat
		['NormalFloat'] = {};
        -- the following line would set it to gray
        -- ['NormalFloat'] = { ctermfg = 'darkgray' };
	};
    -- floting window border
	border = 'solid';
    -- winblend option
	winblend = 0;
})
```
