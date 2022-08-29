local null_ls = require("null-ls")
local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics

-- register any number of sources simultaneously
local sources = {

	--> formatters <--
	-- formatting.latexindent, --> LaTeX formatter
	formatting.stylua, --> lua formatter
	formatting.eslint, --> ts/js formatter
	-- formatting.autopep8, --> python formatter
	formatting.prettier, --> formatter js, ts, jsx, tsx, vue, css, scss, less, html and more ..

	-- diagnostics.markdownlint, --> markdown style and syntax checker
	-- null_ls.builtins.diagnostics.write_good,
	-- null_ls.builtins.diagnostics.chktex,

	-- null_ls.builtins.code_actions.gitsigns,
}

null_ls.setup({
	sources = sources,

	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
		end
	end,
})
