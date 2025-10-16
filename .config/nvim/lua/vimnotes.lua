local vimnotes = {}

-- Default configuration
vimnotes.config = {
  notes_dir = vim.fn.expand("~/.vimnotes"), -- Directory for notes
  extension = ".md", -- File extension for notes
}

-- Helper function to ensure the notes directory exists
local function ensure_notes_dir()
  if not vim.fn.isdirectory(vimnotes.config.notes_dir) then
    vim.fn.mkdir(vimnotes.config.notes_dir, "p")
  end
end

-- Function to create or open a note
function vimnotes.open_note()
  ensure_notes_dir()
  local note_name = vim.fn.input("Note name: ")
  if note_name == "" then
    print("No note name provided!")
    return
  end

  local note_path = string.format("%s/%s%s", vimnotes.config.notes_dir, note_name, vimnotes.config.extension)
  vim.cmd("edit " .. note_path)
end

-- Function to list and open notes
function vimnotes.list_notes()
  ensure_notes_dir()
  local notes = vim.fn.globpath(vimnotes.config.notes_dir, "*" .. vimnotes.config.extension, 0, 1)
  for i, note in ipairs(notes) do
    notes[i] = vim.fn.fnamemodify(note, ":t:r") -- Get base names without extensions
  end

  if #notes == 0 then
    print("No notes found!")
    return
  end

  local choice = vim.fn.inputlist(vim.tbl_flatten({ "Select a note:", notes }))
  if choice > 0 and choice <= #notes then
    local selected_note = notes[choice]
    local note_path = string.format("%s/%s%s", vimnotes.config.notes_dir, selected_note, vimnotes.config.extension)
    vim.cmd("edit " .. note_path)
  else
    print("Invalid selection!")
  end
end

-- Function to insert a link to another note
function vimnotes.insert_link()
  ensure_notes_dir()
  local target_note = vim.fn.input("Link to note: ")
  if target_note == "" then
    print("No note name provided!")
    return
  end

  local link = string.format("[%s](%s%s)", target_note, target_note, vimnotes.config.extension)
  vim.api.nvim_put({ link }, "c", true, true)
end

-- Function to preview links
function vimnotes.preview_link()
  local line = vim.api.nvim_get_current_line()
  local link_pattern = "%[(.-)%]%((.-)%)"
  local name, path = line:match(link_pattern)
  if name and path then
    print(string.format("Link: %s (points to %s)", name, path))
  else
    print("No valid link under cursor!")
  end
end

-- Keybindings setup
function vimnotes.setup_keybindings()
  vim.api.nvim_set_keymap("n", "<leader>nn", ":lua require('vimnotes').open_note()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>nl", ":lua require('vimnotes').list_notes()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>ni", ":lua require('vimnotes').insert_link()<CR>", { noremap = true, silent = true })
  vim.api.nvim_set_keymap("n", "<leader>np", ":lua require('vimnotes').preview_link()<CR>", { noremap = true, silent = true })
end

-- Main setup function
function vimnotes.setup(user_config)
  if user_config then
    vimnotes.config = vim.tbl_deep_extend("force", vimnotes.config, user_config)
  end

  ensure_notes_dir()
  vimnotes.setup_keybindings()
end

return vimnotes

