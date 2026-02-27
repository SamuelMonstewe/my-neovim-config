lvim.plugins = {
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {
      }
      require('bamboo').load()
    end,
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        theme = 'doom', -- 'doom' é o tema clássico e limpo
        config = {
          -- Aqui está a mágica: o cabeçalho personalizado
          header = {
            "",
            " ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            " ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            " ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            " ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            " ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            " ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "",
          },
          -- Personalizar os botões do menu
          center = {
            {
              icon = '  ',
              desc = 'Find File',
              action = 'Telescope find_files',
              key = 'f',
            },
            {
              icon = '  ',
              desc = 'New File',
              action = 'ene | startinsert', -- Cria um buffer vazio e entra em modo de edição
              key = 'n',
            },
            {
              icon = '  ',
              desc = 'Projects',
              action = 'Telescope projects', -- Requer o plugin project.nvim (padrão no Lvim)
              key = 'p',
            },
            {
              icon = '  ',
              desc = 'Recent files',
              action = 'Telescope oldfiles',
              key = 'r',
            },
            {
              icon = '  ',
              desc = 'Find Text',
              action = 'Telescope live_grep', -- Busca texto dentro de todos os arquivos
              key = 't',
            },
            {
              icon = '  ',
              desc = 'Configuration',
              action = 'edit ' .. vim.fn.stdpath('config') .. '/config.lua',
              key = 'c',
            },
            {
              icon = '  ',
              desc = 'Quit',
              action = 'qa', -- Fecha o Neovim completamente
              key = 'q',
            },
         },
          footer = { "⚡ Neovim carregado com sucesso" } -- Rodapé opcional
        }
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  {
    'Xuyuanp/scrollbar.nvim',
    -- no setup required
    init = function()
        local group_id = vim.api.nvim_create_augroup('scrollbar_init', { clear = true })

        vim.api.nvim_create_autocmd({ 'BufEnter', 'WinScrolled', 'WinResized' }, {
            group = group_id,
            desc = 'Show or refresh scrollbar',
            pattern = { '*' },
            callback = function()
                require('scrollbar').show()
            end,
        })
    end,
  },
  {
    "saghen/blink.indent",
    -- Opcional: só carregar quando abrir um arquivo (para iniciar mais rápido)
    event = "BufReadPre", 
    config = function()
      require("blink.indent").setup({
        -- Configuração básica (opcional, ele já vem com bons padrões)
        indent = {
          enabled = true,
          char = "│", -- Caractere da linha (você pode mudar para ▏, ┆, etc.)
        },
        scope = {
          enabled = true, -- Ativa o destaque do escopo atual (bloco onde o cursor está)
          char = "│",
          show_start = false, -- Mostra uma linha sublinhada no início do bloco
          show_end = false,   -- Mostra uma linha sublinhada no fim do bloco
        }
      })
    end
  },
  {
    "nvim-pack/nvim-spectre",
    event = "BufRead",
    config = function()
      require("spectre").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Formatadores para as linguagens que você usa:
          c = { "clang-format" },
          cpp = { "clang-format" },
          cs = { "csharpier" },
          ruby = { "rubocop" },
          python = { "isort", "black" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
        -- Configuração para formatar ao salvar
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  }
}
lvim.colorscheme = "bamboo"
lvim.builtin.alpha.active = false
lvim.builtin.lualine.options.icons_enabled = true
lvim.builtin.lualine.options.theme = "gruvbox"
lvim.builtin.indentlines.active = false
-- Garanta que o estilo está definido para usar as configurações abaixo
lvim.builtin.lualine.style = "default" 

-- Configurando as seções
lvim.builtin.lualine.sections = {
  lualine_a = { 'mode' }, -- Mostra: NORMAL, INSERT, etc.
  lualine_b = { 
    'branch', -- Mostra o ícone do Git e o nome da branch (ex:  main)
    'diff',   -- Mostra contagem de mudanças (+/-)
  }, 
  lualine_c = { 
    -- Exemplo: Adicionando um ícone estático do sistema (ex: Linux) antes do nome do arquivo
    {
      function()
        return "" -- Este é o ícone do Linux (precisa da Nerd Font)
      end,
      color = { fg = "#ffffff" }, -- Cor do ícone (opcional)
      padding = { left = 1, right = 0 }
    },
    'filename' ,
    'diagnostics'
  },
  
  lualine_x = { 
    'encoding', 
    'fileformat',
    'filetype', -- Mostra o ícone da linguagem (ex: C, Python, Lua)
  }, 
  lualine_y = { 'progress' },
  lualine_z = { 'location' },
}

-- Configurando os separadores (as setinhas triangulares estilo "Powerline")
lvim.builtin.lualine.options.component_separators = { left = '', right = ''}
lvim.builtin.lualine.options.section_separators = { left = '', right = ''}
lvim.builtin.which_key.mappings["s"]["r"] = { "<cmd>lua require('spectre').open()<CR>", "Replace (Spectre)" }
lvim.builtin.which_key.mappings["s"]["w"] = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "Replace Word" }
lvim.builtin.which_key.mappings["s"]["f"] = { "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", "Replace in Current File" }
-- Atalhos personalizados para o Terminal
lvim.builtin.which_key.mappings["t"] = {
  name = "+Terminal",
  h = { "<cmd>ToggleTerm size=15 direction=horizontal<cr>", "Terminal Horizontal" },
  v = { "<cmd>ToggleTerm size=60 direction=vertical<cr>", "Terminal Vertical" },
  f = { "<cmd>ToggleTerm direction=float<cr>", "Terminal Flutuante" },
  }
