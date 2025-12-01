require('colorful-menu').setup {}
require('blink.compat').setup {}

local default_sources = { 'lazydev', 'lsp', 'path', 'calc', 'snippets', 'buffer' }
local debug_sources = vim.list_extend(vim.deepcopy(default_sources), { 'dap' })

require('blink-cmp').setup {
  keymap = {
    preset = 'super-tab',
  },
  signature = {
    enabled = true,
    window = {
      border = 'none',
      scrollbar = false,
    },
  },
  sources = {
    default = default_sources,
    per_filetype = { ['dap-repl'] = debug_sources, ['dap-view'] = debug_sources },
    providers = {
      lazydev = {
        module = 'lazydev.integrations.blink',
        -- make lazydev completions top priority (see `:h blink.cmp`)
        score_offset = 100,
      },
      calc = {
        name = 'calc',
        module = 'blink.compat.source',
      },
      dap = {
        name = 'dap',
        module = 'blink.compat.source',
        enabled = function()
          return require('cmp_dap').is_dap_buffer()
        end,
      },
      -- lazydev = {
      --   name = 'LazyDev',
      --   module = 'lazydev.integrations.blink',
      --   fallbacks = { 'lsp' },
      -- },
    },
  },
  appearance = {
    kind_icons = {
      Snippet = '',
    },
  },
  cmdline = {
    completion = {
      menu = {
        auto_show = false,
      },
      ghost_text = {
        enabled = false,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = true,
        },
      },
    },
  },
  completion = {
    keyword = { range = 'prefix' },
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      },
    },
    accept = {
      auto_brackets = {
        enabled = true,
      },
    },
    menu = {
      min_width = 20,
      border = 'none',
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:BlinkCmpMenuSelection,Search:None',
      draw = {
        columns = { { 'kind_icon' }, { 'label', gap = 1 }, { 'source' } },
        components = {
          label = {
            text = require('colorful-menu').blink_components_text,
            highlight = require('colorful-menu').blink_components_highlight,
          },
          kind_icon = {
            text = function(ctx)
              local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
              return kind_icon
            end,
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
          kind = {
            -- (optional) use highlights from mini.icons
            highlight = function(ctx)
              local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
              return hl
            end,
          },
          source = {
            text = function(ctx)
              local map = {
                ['lsp'] = '[]',
                ['path'] = '[󰉋]',
                ['snippets'] = '[]',
              }

              return map[ctx.item.source_id]
            end,
            highlight = 'BlinkCmpDoc',
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
      update_delay_ms = 50,
      window = {
        max_width = math.min(80, vim.o.columns),
        border = 'none',
      },
    },
  },
}
