if true then
  return {}
end

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        go = { "golangcilint" },
        sh = { "shellcheck" },
        markdown = { "vale" },
        asciidoc = { "vale" },
        text = { "vale" },
        yaml = { "yamllint" },
      },
    },
  },
}
