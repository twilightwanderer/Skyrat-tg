/obj/projectile/energy/electrode
	name = "electrode"
	icon_state = "spark"
	color = "#FFFF00"
	nodamage = FALSE
	stamina = 80 // SKYRAT EDIT CHANGE
	stutter = 10 SECONDS
	jitter = 40 SECONDS
	hitsound = 'sound/weapons/taserhit.ogg'
	//range = 7 //ORIGINAL
	range = 5  //SKYRAT EDIT CHANGE - COMBAT
	tracer_type = /obj/effect/projectile/tracer/stun
	muzzle_type = /obj/effect/projectile/muzzle/stun
	impact_type = /obj/effect/projectile/impact/stun
	var/confused_amount = 5 //SKYRAT EDIT ADDITION

/obj/projectile/energy/electrode/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(!ismob(target) || blocked >= 100) //Fully blocked by mob or collided with dense object - burst into sparks!
		do_sparks(1, TRUE, src)
	else if(iscarbon(target))
		var/mob/living/carbon/C = target
		C.adjust_timed_status_effect(15 SECONDS, /datum/status_effect/confusion) //SKYRAT EDIT ADDITION
		C.add_mood_event("tased", /datum/mood_event/tased)
		SEND_SIGNAL(C, COMSIG_LIVING_MINOR_SHOCK)
		if(C.dna && C.dna.check_mutation(/datum/mutation/human/hulk))
			C.say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ), forced = "hulk")
		else if((C.status_flags & CANKNOCKDOWN) && !HAS_TRAIT(C, TRAIT_STUNIMMUNE))
			addtimer(CALLBACK(C, /mob/living/carbon.proc/do_jitter_animation, 20), 5)

/obj/projectile/energy/electrode/on_range() //to ensure the bolt sparks when it reaches the end of its range if it didn't hit a target yet
	do_sparks(1, TRUE, src)
	..()
