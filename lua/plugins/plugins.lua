return {
  {
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = true,
    event = "VeryLazy",
    keys = {
      { "<leader>td", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal Horizontal" },
    },
  },
  {
    "ray-x/go.nvim",
    dependencies = { -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  },
  {
    "motorsir/skel-nvim",
    url = "git@github.com:motosir/skel-nvim.git",
    config = function()
      require("utils.skel-setup").setup()
    end,
  },
}
