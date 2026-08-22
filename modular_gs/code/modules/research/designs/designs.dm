/datum/design/weightanalyzer
	name = "Weight Analyzer"
	id = "weightanalyzer"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(
		/datum/material/iron = SMALL_MATERIAL_AMOUNT * 5,
		/datum/material/glass = SMALL_MATERIAL_AMOUNT * 0.5
		)
	build_path = /obj/item/portable_weight_scanner
	category = list(
		RND_CATEGORY_TOOLS + RND_SUBCATEGORY_TOOLS_MISC
	)

/datum/design/board/heft_scale
	name = "Machine Design (HEF-T Scale Board)"
	desc = "The circuit board for a HEF-T Scale."
	id = "heftscale"
	build_path = /obj/item/circuitboard/machine/heft_scale
	category = list(
		RND_CATEGORY_MACHINE + RND_SUBCATEGORY_MACHINE_SERVICE
	)
