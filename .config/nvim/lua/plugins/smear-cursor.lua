return {
	"sphamba/smear-cursor.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		-- smooth without cursor smear
		-- stiffness = 0.5,
		-- trailing_stiffness = 0.49,
		-- never_draw_over_target = false,

		-- fire hazard
		-- cursor_color = "#FF0B55",
		-- stiffness = 0.3,
		-- trailing_stiffness = 0.1,
		-- trailing_exponent = 5,
		-- hide_target_hack = true,
		-- gamma = 1,

		-- faster smear
		-- stiffness = 0.8,               -- 0.6      [0, 1]
		-- trailing_stiffness = 0.5,      -- 0.3      [0, 1]
		-- distance_stop_animating = 0.5, -- 0.1      > 0
	},
}
