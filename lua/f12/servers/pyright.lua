return {
  settings = {
    pyright = {
      disableOrganizeImports = true,
      autoImportCompletions = true,
      analysis = {
        inlayHints = {
          variableTypes = true,
          callArgumentNames = true,
          functionReturnTypes = true,
        },
      },
    },
  },
}
