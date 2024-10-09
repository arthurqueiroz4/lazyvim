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
    },

    substitutions = {
      ["CLASS_NAME"] = helper.get_classname,
      ["NAMESPACE"] = helper.get_namespace,
      ["TYPE"] = helper.get_type,
      ["PACKAGE"] = helper.get_package,
    },

    author = "MyName",
    namespace = { "MyOrg", "MyApp" },
  })
  -- vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  --   pattern = "*",
  --   callback = function()
  --     require("utils.skel-helper").setup_select_mode()
  --   end,
  -- })
end

return M
