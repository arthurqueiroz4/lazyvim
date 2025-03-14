local M = {}

M.setup = function()
  local helper = require("utils.skel-helper")
  require("skel-nvim").setup({
    templates_dir = "/home/arthur/.config/nvim/skeleton",

    skel_enabled = true,
    apply_skel_for_empty_file = true,

    mappings = {
      ["*.cs"] = "csharp.skel",
      ["*.java"] = "java.skel",
      ["*.go"] = "go.skel",
    },

    substitutions = {
      ["CLASS_NAME"] = helper.get_classname,
      ["NAMESPACE"] = helper.get_namespace,
      ["TYPE"] = helper.get_type,
      ["PACKAGE"] = helper.get_package,
      ["FOLDER_NAME"] = helper.get_folder_name,
    },
  })
end

return M
