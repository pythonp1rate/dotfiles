-- ~/.config/nvim/lua/config/venv.lua
-- Auto-detect Python venvs and apply to LSP/DAP/host Python.

local M = {}

-----------------------------------------------------------------------
-- Helper: find the nearest directory upward containing targets
-----------------------------------------------------------------------
local function find_ancestor(start, targets)
  local dir = vim.fn.fnamemodify(start or ".", ":p")

  while dir and dir ~= "" and dir ~= "/" do
    for _, t in ipairs(targets) do
      local p = dir .. "/" .. t
      if vim.fn.isdirectory(p) == 1 or vim.fn.filereadable(p) == 1 then
        return dir
      end
    end

    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end

  return nil
end

-----------------------------------------------------------------------
-- Detect Python interpreter from venv / Poetry / Pipenv / Conda
-----------------------------------------------------------------------
local function detect_python()
  local buf = vim.api.nvim_buf_get_name(0)
  local start_dir = buf ~= "" and vim.fn.fnamemodify(buf, ":p:h") or vim.fn.getcwd()

  local root = find_ancestor(start_dir, {
    ".venv",
    "venv",
    "env",
    "pyproject.toml",
    "Pipfile",
    "poetry.lock",
    "environment.yml",
    "requirements.txt",
  })

  if not root then
    return nil
  end

  -------------------------------------------------------------------
  -- 1. Local .venv / venv / env folder
  -------------------------------------------------------------------
  for _, v in ipairs({ ".venv", "venv", "env" }) do
    local python = root .. "/" .. v .. "/bin/python"
    if vim.fn.executable(python) == 1 then
      return python
    end
  end

  -------------------------------------------------------------------
  -- 2. Poetry
  -------------------------------------------------------------------
  if vim.fn.filereadable(root .. "/pyproject.toml") == 1 then
    local handle = vim.system({ "poetry", "env", "info", "-p" }, { text = true })
    local result = handle:wait()
    if result and result.code == 0 then
      local env_path = vim.fn.trim(result.stdout or "")
      if env_path ~= "" then
        local python = env_path .. "/bin/python"
        if vim.fn.executable(python) == 1 then
          return python
        end
      end
    end
  end

  -------------------------------------------------------------------
  -- 3. Pipenv
  -------------------------------------------------------------------
  if vim.fn.filereadable(root .. "/Pipfile") == 1 then
    local handle = vim.system({ "pipenv", "--venv" }, { text = true })
    local result = handle:wait()
    if result and result.code == 0 then
      local env_path = vim.fn.trim(result.stdout or "")
      if env_path ~= "" then
        local python = env_path .. "/bin/python"
        if vim.fn.executable(python) == 1 then
          return python
        end
      end
    end
  end

  -------------------------------------------------------------------
  -- 4. Conda
  -------------------------------------------------------------------
  if vim.fn.filereadable(root .. "/environment.yml") == 1 then
    local prefix = os.getenv("CONDA_PREFIX")
    if prefix then
      local python = prefix .. "/bin/python"
      if vim.fn.executable(python) == 1 then
        return python
      end
    end
  end

  return nil
end

-----------------------------------------------------------------------
-- Apply Python path to Neovim host, Pyright, DAP Python
-----------------------------------------------------------------------
local function apply_python(python)
  if not python or python == "" then
    return
  end

  -- For Python support in Neovim
  vim.g.python3_host_prog = python

  -- Update Pyright safely
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.name == "pyright" then
      -- Wrap client.notify so LuaLS sees correct types
      local function safe_notify(method, params)
        ---@diagnostic disable-next-line: param-type-mismatch
        client.notify(method, params)
      end

      safe_notify("workspace/didChangeConfiguration", {
        settings = { python = { pythonPath = python } },
      })
    end
  end

  -- Update DAP Python if installed
  local ok, dap_python = pcall(require, "dap-python")
  if ok then
    pcall(dap_python.setup, python)
  end

  vim.notify("Python venv detected: " .. python, vim.log.levels.INFO)
end

-----------------------------------------------------------------------
-- Setup autocommands & commands
-----------------------------------------------------------------------
function M.setup()
  -- Auto-detect when entering Python buffers or starting editor
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "VimEnter" }, {
    callback = function()
      if vim.bo.filetype ~= "python" then
        return
      end
      local python = detect_python()
      if python then
        apply_python(python)
      end
    end,
  })

  -- Auto-activate venv inside ToggleTerm
  vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*toggleterm#*",
    callback = function()
      local venv = vim.g.python_venv_path
      if venv and venv ~= "" then
        local activate = venv .. "/bin/activate"
        vim.fn.chansend(vim.b.terminal_job_id, "source " .. activate .. "\n")
      end
    end,
  })

  -- Manual command
  vim.api.nvim_create_user_command("DetectPythonVenv", function()
    local python = detect_python()
    if python then
      apply_python(python)
    else
      vim.notify("No Python venv detected.", vim.log.levels.WARN)
    end
  end, { desc = "Manually re-detect Python virtualenv" })
end

return M
