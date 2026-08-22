/obj/structure/scale
	name = "weighing scale"
	desc = "You can weigh yourself with this."
	icon = 'modular_gs/icons/obj/scale.dmi'
	icon_state = "scale"
	anchored = TRUE
	resistance_flags = NONE
	max_integrity = 250
	integrity_failure = 25
	layer = OBJ_LAYER
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 3)
	/// Component responsible for scale behavior
	var/datum/component/weight_scale/scale_component

/obj/structure/scale/wrench_act_secondary(mob/living/user, obj/item/tool)
	..()
	tool.play_tool_sound(src)
	deconstruct(disassembled = TRUE)
	return TRUE

/obj/structure/scale/atom_deconstruct(disassembled)
	for(var/datum/material/mat as anything in custom_materials)
		new mat.sheet_type(loc, FLOOR(custom_materials[mat] / SHEET_MATERIAL_AMOUNT, 1))

/obj/structure/scale/Initialize(mapload)
	. = ..()
	scale_component = AddComponent(/datum/component/weight_scale)

/obj/structure/scale/Destroy(force)
	if(scale_component)
		QDEL_NULL(scale_component)

	return ..()

/obj/structure/scale/examine(mob/user)
	. = ..()
	. += span_notice("It's held together by a couple of <b>bolts</b>.")

/obj/structure/scale/ui_interact(mob/user)
	scale_component.ui_interact(user)
