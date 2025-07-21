local function pick_runtime()
  local runtimes = { 'npm', 'yarn', 'pnpm', 'bun' }

  local co, ismain = coroutine.running()
  local ui = require 'dap.ui'
  local pick = (co and not ismain) and ui.pick_one or ui.pick_one_sync
  local result = pick(runtimes, 'Select runtime', function(runtime)
    return runtime
  end)
  return result or require('dap').ABORT
end

local function pick_script()
  local pilot = require 'package-pilot'

  local current_dir = vim.fn.getcwd()
  local package = pilot.find_package_file { dir = current_dir }

  if not package then
    vim.notify('No package.json found', vim.log.levels.ERROR)
    return require('dap').ABORT
  end

  local scripts = pilot.get_all_scripts(package)

  local label_fn = function(script)
    return script
  end

  local co, ismain = coroutine.running()
  local ui = require 'dap.ui'
  local pick = (co and not ismain) and ui.pick_one or ui.pick_one_sync
  local result = pick(scripts, 'Select script', label_fn)
  return result or require('dap').ABORT
end

return {
  'mfussenegger/nvim-dap',
  optional = true,
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, 'js-debug-adapter')
      end,
    },
    'banjo/package-pilot.nvim',
  },
  opts = function()
    local dap = require 'dap'

    if not dap.adapters['pwa-node'] then
      require('dap').adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            vim.fn.stdpath 'data' .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }
    end

    if not dap.adapters['node'] then
      dap.adapters['node'] = function(cb, config)
        if config.type == 'node' then
          config.type = 'pwa-node'
        end
        local nativeAdapter = dap.adapters['pwa-node']
        if type(nativeAdapter) == 'function' then
          nativeAdapter(cb, config)
        else
          cb(nativeAdapter)
        end
      end
    end

    local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', 'vue' }

    local current_file = vim.fn.expand '%:t'

    for _, language in ipairs(js_filetypes) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = 'pwa-node',
            request = 'launch',
            name = 'Launch file',
            program = '${file}',
            cwd = '${workspaceFolder}',
          },
          {
            type = 'pwa-node',
            request = 'attach',
            name = 'Attach',
            processId = require('dap.utils').pick_process,
            cwd = '${workspaceFolder}',
          },
          {
            name = 'tsx (' .. current_file .. ')',
            type = 'node',
            request = 'launch',
            program = '${file}',
            runtimeExecutable = 'tsx',
            cwd = '${workspaceFolder}',
            console = 'integratedTerminal',
            internalConsoleOptions = 'neverOpen',
            skipFiles = { '<node_internals>/**', '${workspaceFolder}/node_modules/**' },
          },
          {
            type = 'node',
            request = 'launch',
            name = 'pick script',
            runtimeExecutable = pick_runtime,
            runtimeArgs = { 'run', pick_script },
            cwd = '${workspaceFolder}',
          },
        }
      end
    end

    local vscode = require 'dap.ext.vscode'
    vscode.type_to_filetypes['node'] = js_filetypes
    vscode.type_to_filetypes['pwa-node'] = js_filetypes
  end,
}
