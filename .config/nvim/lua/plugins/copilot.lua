local Plugin = { "zbirenbaum/copilot.lua" }
Plugin.enabled = false
Plugin.event = { "InsertEnter" }

function Plugin.config()
	require("copilot").setup({
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
		},
		panel = {
			enabled = true,
		},
	})
end

return Plugin
