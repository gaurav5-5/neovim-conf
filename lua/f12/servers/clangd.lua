return {
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  settings = {
    InlayHints = {
      BlockEnd = true,
      Designators = true,
      Enabled = true,
      ParameterNames = true,
      DeducedTypes = true,
      TypeNameLimit = 24,
    },
    Hover = {
      ShowAKA = true,
    },
  },
}
