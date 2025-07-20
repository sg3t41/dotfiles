local Plugin = {  "JavaHello/spring-boot.nvim"}

return {
  "JavaHello/spring-boot.nvim",
  lazy = true,
  dependencies = {
    "mfussenegger/nvim-jdtls", -- or nvim-java, nvim-lspconfig
  },
  config = false
}
