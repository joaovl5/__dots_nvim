local function set_python_path(path)
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'basedpyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client.notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

local schemastore = require 'schemastore'
local servers = {
  basedpyright = {
    on_attach = function(client, bufnr)
      vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
        client:exec_cmd {
          command = 'basedpyright.organizeimports',
          arguments = { vim.uri_from_bufnr(bufnr) },
        }
      end, {
        desc = 'Organize Imports',
      })

      vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
        desc = 'Reconfigure basedpyright with the provided python path',
        nargs = 1,
        complete = 'file',
      })
    end,
    settings = {
      basedpyright = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'recommended',
          diagnosticMode = 'workspace',

          reportUnknownParameterType = false,
          reportExplicitAny = false,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = schemastore.json.schemas(),
      },
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          -- disable for using our schemastore plugin
          enable = false,
          url = '',
        },
        schemas = schemastore.yaml.schemas(),
      },
    },
  },
}

-- ensure the servers and tools above are installed
local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
  'stylua', -- Used to format Lua code
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

-- include blink.cmp capabilities on lspconfig
local capabilities = require('blink.cmp').get_lsp_capabilities()

require('mason-lspconfig').setup {
  ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
  automatic_installation = false,
  handlers = {
    function(server_name)
      local server = servers[server_name] or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for ts_ls)
      server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      require('lspconfig')[server_name].setup(server)
    end,
  },
}

-- misc
require('garbage-day').setup {
  grace_period = 60 * 15, -- waits 15 minutes for the kill
  wakeup_delay = 1, -- waits 1 second to ressucitate
}

-- specific language support tuning
require 'plugins.languages.markdown'
require 'plugins.languages.lua'
require 'plugins.languages.typescript'
require 'plugins.languages.python'
