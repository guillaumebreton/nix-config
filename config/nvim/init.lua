----------------
--- SETTINGS ---
----------------

-- Set the colorscheme
vim.cmd [[colorscheme nightfox]]

-- Disable netrw at the very start of our init.lua, because we use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "

vim.opt.termguicolors = true                      -- Enable 24-bit RGB colors

vim.opt.number = true                             -- Show line numbers
vim.opt.showmatch = true                          -- Highlight matching parenthesis
vim.opt.splitright = true                         -- Split windows right to the current windows
vim.opt.splitbelow = true                         -- Split windows below to the current windows
vim.opt.autowrite = true                          -- Automatically save before :next, :make etc.
vim.opt.autochdir = false                         -- Don't Change CWD when I open a file

vim.opt.mouse = 'a'                               -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'                 -- Copy/paste to system clipboard
vim.opt.swapfile = false                          -- Don't use swapfile
vim.opt.ignorecase = true                         -- Search case insensitive...
vim.opt.smartcase = true                          -- ... but not it begins with upper case
vim.opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- Indent Settings
vim.opt.expandtab = true  -- expand tabs into spaces
vim.opt.shiftwidth = 2    -- number of spaces to use for each step of indent.
vim.opt.tabstop = 2       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.wrap = true

-- auto formatting
vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]

----------------------------
-- PLUGINS CONFIGURATION
----------------------------

require('neoscroll').setup(
-- -- All these keys will be mapped to their corresponding default scrolling animation
-- mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
--             '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
-- hide_cursor = true,          -- Hide cursor while scrolling
-- stop_eof = true,             -- Stop at <EOF> when scrolling downwards
-- respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
-- cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
-- easing_function = nil,       -- Default easing function
-- pre_hook = nil,              -- Function to run before the scrolling animation starts
-- post_hook = nil,             -- Function to run after the scrolling animation ends
-- performance_mode = false,    -- Disable "Performance Mode" on all buffers.
)

local lsp = require("lsp-zero")

lsp.preset("recommended")

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil
local luasnip = require("luasnip")

-- Better mapping for cmp
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


require('cmp').setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif cmp.visible() then
        cmp.select_next_item()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  -- don't auto select item
  preselect = cmp.PreselectMode.None,
  window = {
    documentation = cmp.config.window.bordered(),
  },
  view = {
    entries = {
      name = "custom",
      selection_order = "near_cursor",
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Insert,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip", keyword_length = 2 },
    { name = "buffer",  keyword_length = 5 },
  },
})
lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set('n', '<leader>v', "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set('n', '<leader>s', "<cmd>belowright split | lua vim.lsp.buf.definition()<CR>", opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>cl', vim.lsp.codelens.run, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
end)

lsp.setup()


-- When you don't have mason.nvim installed
-- You'll need to list the servers installed in your system
lsp.setup_servers({
  'rust_analyzer',
  'gopls',
  'tsserver',
  "html",
})
-- specific lsp setup for elixirls
require 'lspconfig'.elixirls.setup {
  cmd = { "elixir-ls" },
}


vim.diagnostic.config({
  virtual_text = true
})

-- Tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  filters = {
    dotfiles = true,
  },
})

-- Treesitter
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  autopairs = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ["iB"] = "@block.inner",
        ["aB"] = "@block.outer",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']]'] = '@function.outer',
      },
      goto_next_end = {
        [']['] = '@function.outer',
      },
      goto_previous_start = {
        ['[['] = '@function.outer',
      },
      goto_previous_end = {
        ['[]'] = '@function.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
----------------------------
-- PLUGIN MAPPINGS
----------------------------

-- telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pb', builtin.live_grep, {})
vim.keymap.set('n', '<leader>ps', function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

-- lua snip
require("luasnip.loaders.from_vscode").lazy_load()

-- comment
require('nvim_comment').setup({ comment_empty = false })

-- Copilot
-- disable tab keymap for Copilot
vim.g.copilot_no_tab_map = true
vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")',
  { silent = true, expr = true, noremap = true, replace_keycodes = false })


-- leap
require('leap').add_default_mappings()




----------------------------
-- CUSTOM MAPPINGS
----------------------------
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "J", "mzJ`z")

-- move the screen one page downward and center the cursor
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- move the screen one page backward and center the cursor
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- unknow
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- file tree mapping
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFileToggle<CR>', { noremap = true })

-- Better split switching
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- Fast saving
vim.keymap.set('n', '<Leader>w', ':write!<CR>')
vim.keymap.set('n', '<Leader>q', ':wqall!<CR>', { silent = true })
vim.opt.number = true     -- Show line numbers
vim.opt.showmatch = true  -- Highlight matching parenthesis
vim.opt.splitright = true -- Split windows right to the current windows
vim.opt.splitbelow = true -- Split windows below to the current windows
vim.opt.autowrite = true  -- Automatically save before :next, :make etc.
vim.opt.autochdir = false -- Change CWD when I open a file


-- diagnostics
vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>ds', vim.diagnostic.setqflist)

-- Trouble
vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>', { silent = true })

-- Visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Autoformat

require("conform").setup({
  notify_on_error = true,
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true -- if no defined or available formatter, try lsp formatter
  },
  formatters_by_ft = {
    -- lua = {{"lua_format", "stylua"}},
    python = { "black" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettier", "eslint_d" } },
    javascriptreact = { { "prettier", "eslint_d" } },
    typescript = { { "prettier", "eslint_d" } },
    typescriptreact = { { "prettier", "eslint_d" } },
    vue = { { "prettier", "eslint_d" } },
    scss = { { "prettier", "eslint_d" } },
    html = { { "prettier", "eslint_d" } },
    css = { { "prettier", "eslint_d" } },
    json = { { "prettier", "eslint_d" } },
    jsonc = { { "prettier", "eslint_d" } },
    yaml = { { "prettier", "eslint_d" } },
    svelte = { { "prettier", "eslint_d" } },
    nix = { "alejandra" },
    golang = { "gofmt" }
  }
})


-- linting
-- See https://github.com/zmre/pwnvim/blob/main/pwnvim/plugins.lua
require('lint').linters_by_ft = {
  markdown = { 'vale' },
  css = { 'prettier' },
  svelte = { 'eslint_d' },
  python = { "mypy", "ruff" },
  nix = { "statix" },
  bash = { "shellcheck" },
  typescript = { "prettier" },
  javascript = { "prettier" },
  rust = { "rustfmt" },
  golang = { "golangcilint" }
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function() require("lint").try_lint() end
})
