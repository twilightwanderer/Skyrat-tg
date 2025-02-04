/obj/item/bodypart
	/// Whether or not this bodypart can be surgically removed. Independant of the `dismemberable` variable,
	/// meaning that you can have one and not the other, both or none, and all will still work. This only
	/// affects amputation and augmentation surgeries.
	var/can_be_surgically_removed = TRUE

/**
 * # This should only be ran by augments, if you don't know what you're doing, you shouldn't be touching this.
 * A setter for the `icon_static` variable of the bodypart. Runs through `icon_exists()` for sanity, and it won't
 * change anything in the event that the check fails.
 *
 * Arguments:
 * * new_icon - The new icon filepath that you want to replace `icon_static` with.
 */
/obj/item/bodypart/proc/set_icon_static(new_icon)
	var/state_to_verify = "[limb_id]_[body_zone][is_dimorphic ? "_[limb_gender]" : ""]"
	if(icon_exists(new_icon, state_to_verify, scream = TRUE))
		icon_static = new_icon
