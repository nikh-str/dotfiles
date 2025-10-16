-- require'vim.lsp.config'.texlab.setup{
    -- cmd={ "texlab" }
-- }
vim.lsp.enable('ltex')

settings={
    ltex = {
        language = "en-GB",
        enabled = { "bibtex", "gitcommit", "markdown", "org", "tex", "restructuredtext", "rsweave", "latex", "quarto", "rmd", "context", "html", "xhtml", "mail", "plaintext" }
    },
}
