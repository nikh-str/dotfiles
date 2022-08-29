local M = {}
local present, cmp = pcall(require, "cmp")

if not present then
	return
end

vim.opt.completeopt = "menuone,noselect"
local lspkind = require("lspkind")

M.config = function()
	-- nvim-cmp setup
	cmp.setup({
		snippet = {
			expand = function(args)
				-- require("luasnip").lsp_expand(args.body)
				vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
			end,
		},
		formatting = {
			format = lspkind.cmp_format({ with_text = true, maxwidth = 50 }),
		},
		mapping = {
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Replace,
				-- select = true,
			}),
			-- ["<C-j>"] = function(fallback)
			--    if cmp.visible() then
			--       cmp.select_next_item()
			--    elseif require("luasnip").expand_or_jumpable() then
			--       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			--    else
			--       fallback()
			--    end
			-- end,
			-- ["<C-k>"] = function(fallback)
			--    if cmp.visible() then
			--       cmp.select_prev_item()
			--    elseif require("luasnip").jumpable(-1) then
			--       vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			--    else
			--       fallback()
			--    end
			-- end,
		},
		source_names = {
			nvim_lsp = "(LSP)",
			emoji = "(Emoji)",
			path = "(Path)",
			calc = "(Calc)",
			cmp_tabnine = "(Tabnine)",
			vsnip = "(Snippet)",
			luasnip = "(Snippet)",
			buffer = "(Buffer)",
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "ultisnips" },
			{ name = "buffer" },
			{ name = "nvim_lua" },
			{ name = "path" },
			{ name = "neorg" },
		}),
	})
end
return M
