#define COOLDOWN_RESPONSE	"response_cooldown"

// HEF-T Scale, ported from WG13 and modified for our use
/obj/machinery/heft_scale
	name = "HEF-T Scale"
	desc = "That's HEF-T! A durable scale with a built in AI intellicard and LED display. A perfect weight management companion built by Lustwish."
	icon = 'modular_gs/icons/obj/scale.dmi'
	icon_state = "heft_scale_off"
	anchored = FALSE
	density = FALSE
	resistance_flags = NONE
	max_integrity = 250
	integrity_failure = 25
	circuit = /obj/item/circuitboard/machine/heft_scale
	processing_flags = START_PROCESSING_MANUALLY
	/// Component responsible for scale behavior
	var/datum/component/weight_scale/scale_component

/obj/machinery/heft_scale/anchored
	anchored = TRUE

/obj/machinery/heft_scale/Initialize(mapload)
	. = ..()
	scale_component = AddComponent(/datum/component/weight_scale/heft_scale)

/obj/machinery/heft_scale/Destroy(force)
	if(scale_component)
		qdel(scale_component)

	return ..()

/// plays a sound and teases the person on it based on their weight
/obj/machinery/heft_scale/proc/generate_weight_response(fatness)
	if(TIMER_COOLDOWN_RUNNING(src, COOLDOWN_RESPONSE))
		return

	switch (fatness)
		if (0 to FATNESS_LEVEL_FATTER)
			say(pick(
				"Looking good!",
				"All Healthy Here!",
				"Keeping trim I see!",
				"Nice bod!"))
			icon_state = "heft_scale_normal"
			playsound(src, 'sound/machines/ping.ogg', 60, 1)
		if (FATNESS_LEVEL_FATTER to FATNESS_LEVEL_EXTREMELY_OBESE)
			say(pick(
				"Looking kinda' chunky there!",
				"Woah, seems you've packed on a few pounds!",
				"Easy on the snacks there!",
				"May I suggest eating a salad?"))
			icon_state = "heft_scale_chubby"
			playsound(src, 'sound/machines/beep/twobeep.ogg', 60, 1)
		if (FATNESS_LEVEL_EXTREMELY_OBESE to FATNESS_LEVEL_IMMOBILE)
			say(pick(
				"Careful! You almost +BROKE+ me there!",
				"I just registered a 4.0 on the richter scale. +You+ wouldn't happen to know anything about that would you?",
				"Hey! This unit isn't meant to weigh livestock! Get off!",
				"Heeeelp! Pressure damage detected!"))
			icon_state = "heft_scale_overweight"
			playsound(src, 'sound/machines/buzz/buzz-two.ogg', 60, 1)
		if (FATNESS_LEVEL_IMMOBILE to INFINITY)	// TODO: missing heft_scale_obese level
			say(pick(
				"ERROR: MAXIMUM WEIGHT EXCEEDED.",
				"INTERNAL EXCEPTION: LARDASS FOUND.",
				"SYSTEM MESSAGE: HAVE MERCY!",
				"SUBJECT EXCEEDS WEIGHT PARAMATERS FOR THIS UNIT."))
			icon_state = "heft_scale_bsod"
			playsound(src, 'sound/machines/terminal/terminal_error.ogg', 60, 1)
	
	addtimer(VARSET_CALLBACK(src, icon_state, "heft_scale_off"), (10 SECONDS))
	TIMER_COOLDOWN_START(src, COOLDOWN_RESPONSE, (10 SECONDS))

/obj/machinery/heft_scale/ui_interact(mob/user)
	scale_component.ui_interact(user)

/obj/item/circuitboard/machine/heft_scale
	name = "HEF-T Scale"
	build_path = /obj/machinery/heft_scale
	req_components = list(
		/obj/item/stack/sheet/glass = 1,
		)
	needs_anchored = FALSE

#undef COOLDOWN_RESPONSE
