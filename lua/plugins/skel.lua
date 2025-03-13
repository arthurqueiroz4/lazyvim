return {
  {
    "motorsir/skel-nvim",
    url = "git@github.com:motosir/skel-nvim.git",
    config = function()
      require("utils.skel-setup").setup()
    end,
  },
}
