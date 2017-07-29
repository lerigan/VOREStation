/obj/item/clothing/suit/armor
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/weapon/gun/projectile,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/device/flashlight/maglight,/obj/item/clothing/head/helmet)
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	item_flags = THICKMATERIAL

	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6

/obj/item/clothing/suit/mob_can_equip(var/mob/living/carbon/human/H, slot, disable_warning = 0)
	if(..()) //This will only run if no other problems occured when equiping.
		for(var/obj/item/clothing/I in list(H.gloves, H.shoes))
			if(I && (src.body_parts_covered & ARMS && I.body_parts_covered & ARMS) )
				H << "<span class='warning'>You can't wear \the [src] with \the [I], it's in the way.</span>"
				return 0
			if(I && (src.body_parts_covered & LEGS && I.body_parts_covered & LEGS) )
				H << "<span class='warning'>You can't wear \the [src] with \the [I], it's in the way.</span>"
				return 0
		return 1

/obj/item/clothing/suit/armor/vest
	name = "armor"
	desc = "An armored vest that protects against some damage."
	icon_state = "armor"
	blood_overlay_type = "armor"
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 10, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/vest/alt
	name = "security armor"
	desc = "An armored vest that protects against some damage. This one has a NanoTrasen corporate badge."
	icon_state = "armoralt"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")

/obj/item/clothing/suit/armor/vest/security
	name = "security armor"
	desc = "An armored vest that protects against some damage. This one has a corporate badge."
	icon_state = "armorsec"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")

/obj/item/clothing/suit/armor/riot
	name = "riot vest"
	desc = "A vest with heavy padding to protect against melee attacks."
	icon_state = "riot"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 80, bullet = 10, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	flags_inv = HIDEJUMPSUIT
	siemens_coefficient = 0.5

/obj/item/clothing/suit/armor/riot/alt
	icon_state = "riot_new"
	item_state_slots = list(slot_r_hand_str = "riot_new", slot_l_hand_str = "riot_new")

/obj/item/clothing/suit/armor/bulletproof
	name = "bullet resistant vest"
	desc = "A vest that excels in protecting the wearer against high-velocity solid projectiles."
	icon_state = "bulletproof"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	blood_overlay_type = "armor"
	slowdown = 0.5
	armor = list(melee = 10, bullet = 80, laser = 10, energy = 10, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.7

/obj/item/clothing/suit/armor/bulletproof/alt
	icon_state = "bulletproof_new"
	item_state_slots = list(slot_r_hand_str = "bulletproof_new", slot_l_hand_str = "bulletproof_new")
	blood_overlay_type = "armor"

/obj/item/clothing/suit/armor/laserproof
	name = "ablative armor vest"
	desc = "A vest that excels in protecting the wearer against energy projectiles."
	icon_state = "armor_reflec"
	blood_overlay_type = "armor"
	slowdown = 0.5
	armor = list(melee = 10, bullet = 10, laser = 80, energy = 50, bomb = 0, bio = 0, rad = 0)
	siemens_coefficient = 0.1

/obj/item/clothing/suit/armor/laserproof/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(istype(damage_source, /obj/item/projectile/energy) || istype(damage_source, /obj/item/projectile/beam))
		var/obj/item/projectile/P = damage_source

		if(P.reflected) // Can't reflect twice
			return ..()

		var/reflectchance = 40 - round(damage/3)
		if(!(def_zone in list(BP_TORSO, BP_GROIN)))
			reflectchance /= 2
		if(P.starting && prob(reflectchance))
			visible_message("<span class='danger'>\The [user]'s [src.name] reflects [attack_text]!</span>")

			// Find a turf near or on the original location to bounce to
			var/new_x = P.starting.x + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
			var/new_y = P.starting.y + pick(0, 0, 0, 0, 0, -1, 1, -2, 2)
			var/turf/curloc = get_turf(user)

			// redirect the projectile
			P.redirect(new_x, new_y, curloc, user)
			P.reflected = 1

			return PROJECTILE_CONTINUE // complete projectile permutation

/obj/item/clothing/suit/armor/combat
	name = "combat vest"
	desc = "A vest that protects the wearer from several common types of weaponry."
	icon_state = "combat"
	blood_overlay_type = "armor"
	slowdown = 0.5
	armor = list(melee = 50, bullet = 50, laser = 50, energy = 30, bomb = 30, bio = 0, rad = 0)
	siemens_coefficient = 0.6

/obj/item/clothing/suit/armor/tactical
	name = "tactical armor"
	desc = "A suit of armor most often used by Special Weapons and Tactics squads. Includes padded vest with pockets along with shoulder and kneeguards."
	icon_state = "swatarmor"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	slowdown = 1
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)
	siemens_coefficient = 0.7

/obj/item/clothing/suit/armor/swat
	name = "swat suit"
	desc = "A heavily armored suit that protects against moderate damage. Used in special operations."
	icon_state = "deathsquad"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	item_flags = STOPPRESSUREDAMAGE | THICKMATERIAL
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS
	allowed = list(/obj/item/weapon/gun,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency/oxygen,/obj/item/clothing/head/helmet)
	slowdown = 1
	w_class = ITEMSIZE_HUGE
	armor = list(melee = 80, bullet = 60, laser = 50,energy = 25, bomb = 50, bio = 100, rad = 100)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6


/obj/item/clothing/suit/armor/swat/officer
	name = "officer jacket"
	desc = "An armored jacket used in special operations."
	icon_state = "detective"
	item_state_slots = list(slot_r_hand_str = "detective", slot_l_hand_str = "detective")
	blood_overlay_type = "coat"
	flags_inv = 0
	body_parts_covered = UPPER_TORSO|ARMS


/obj/item/clothing/suit/armor/det_suit
	name = "armor"
	desc = "An armored vest with a detective's badge on it."
	icon_state = "detective-armor"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	blood_overlay_type = "armor"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 10, bio = 0, rad = 0)


//Reactive armor
//When the wearer gets hit, this armor will teleport the user a short distance away (to safety or to more danger, no one knows. That's the fun of it!)
/obj/item/clothing/suit/armor/reactive
	name = "Reactive Teleport Armor"
	desc = "Someone separated our Research Director from their own head!"
	var/active = 0.0
	icon_state = "reactiveoff"
	item_state_slots = list(slot_r_hand_str = "armor_reflec_old", slot_l_hand_str = "armor_reflec_old")
	blood_overlay_type = "armor"
	slowdown = 1
	armor = list(melee = 0, bullet = 0, laser = 0, energy = 0, bomb = 0, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/reactive/handle_shield(mob/user, var/damage, atom/damage_source = null, mob/attacker = null, var/def_zone = null, var/attack_text = "the attack")
	if(prob(50))
		user.visible_message("<span class='danger'>The reactive teleport system flings [user] clear of the attack!</span>")
		var/list/turfs = new/list()
		for(var/turf/T in orange(6, user))
			if(istype(T,/turf/space)) continue
			if(T.density) continue
			if(T.x>world.maxx-6 || T.x<6)	continue
			if(T.y>world.maxy-6 || T.y<6)	continue
			turfs += T
		if(!turfs.len) turfs += pick(/turf in orange(6))
		var/turf/picked = pick(turfs)
		if(!isturf(picked)) return

		var/datum/effect/effect/system/spark_spread/spark_system = new /datum/effect/effect/system/spark_spread()
		spark_system.set_up(5, 0, user.loc)
		spark_system.start()
		playsound(user.loc, "sparks", 50, 1)

		user.loc = picked
		return PROJECTILE_FORCE_MISS
	return 0

/obj/item/clothing/suit/armor/reactive/attack_self(mob/user as mob)
	active = !( active )
	if (active)
		user << "<font color='blue'>The reactive armor is now active.</font>"
		icon_state = "reactive"
	else
		user << "<font color='blue'>The reactive armor is now inactive.</font>"
		icon_state = "reactiveoff"
		add_fingerprint(user)
	return

/obj/item/clothing/suit/armor/reactive/emp_act(severity)
	active = 0
	icon_state = "reactiveoff"
	..()

//Non-hardsuit ERT armor.
/obj/item/clothing/suit/armor/vest/ert
	name = "emergency response team armor"
	desc = "A set of armor worn by members of the Emergency Response Team."
	icon_state = "ertarmor_cmd"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 20, bio = 0, rad = 0)

//Commander
/obj/item/clothing/suit/armor/vest/ert/command
	name = "emergency response team commander armor"
	desc = "A set of armor worn by the commander of an Emergency Response Team. Has blue highlights."

//Security
/obj/item/clothing/suit/armor/vest/ert/security
	name = "emergency response team security armor"
	desc = "A set of armor worn by security members of the Emergency Response Team. Has red highlights."
	icon_state = "ertarmor_sec"

//Engineer
/obj/item/clothing/suit/armor/vest/ert/engineer
	name = "emergency response team engineer armor"
	desc = "A set of armor worn by engineering members of the Emergency Response Team. Has orange highlights."
	icon_state = "ertarmor_eng"

//Medical
/obj/item/clothing/suit/armor/vest/ert/medical
	name = "emergency response team medical armor"
	desc = "A set of armor worn by medical members of the Emergency Response Team. Has red and white highlights."
	icon_state = "ertarmor_med"

//New Vests
/obj/item/clothing/suit/storage/vest
	name = "armor vest"
	desc = "A simple kevlar plate carrier."
	icon_state = "kvest"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	armor = list(melee = 40, bullet = 30, laser = 30, energy = 10, bomb = 10, bio = 0, rad = 0)
	allowed = list(/obj/item/weapon/gun,/obj/item/weapon/reagent_containers/spray/pepper,/obj/item/ammo_magazine,/obj/item/ammo_casing,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/device/flashlight/maglight,/obj/item/clothing/head/helmet)

	body_parts_covered = UPPER_TORSO|LOWER_TORSO
	item_flags = THICKMATERIAL

	cold_protection = UPPER_TORSO|LOWER_TORSO
	min_cold_protection_temperature = ARMOR_MIN_COLD_PROTECTION_TEMPERATURE
	heat_protection = UPPER_TORSO|LOWER_TORSO
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0.6

/obj/item/clothing/suit/storage/vest/officer
	name = "officer armor vest"
	desc = "A simple kevlar plate carrier. This one has a security holobadge clipped to the chest."
	icon_state = "officervest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "officervest_badge"
	icon_nobadge = "officervest_nobadge"

/obj/item/clothing/suit/storage/vest/warden
	name = "warden armor vest"
	desc = "A simple kevlar plate carrier. This one has a silver badge clipped to the chest."
	icon_state = "wardenvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "wardenvest_badge"
	icon_nobadge = "wardenvest_nobadge"

/obj/item/clothing/suit/storage/vest/wardencoat
	name = "Warden's jacket"
	desc = "An armoured jacket with silver rank pips and livery."
	icon_state = "warden_jacket"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

/obj/item/clothing/suit/storage/vest/wardencoat/alt
	name = "Warden's jacket"
	desc = "An armoured jacket with silver rank pips and livery."
	icon_state = "warden_alt"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS

/obj/item/clothing/suit/storage/vest/hos
	name = "head of security armor vest"
	desc = "A simple kevlar plate carrier. This one has a gold badge clipped to the chest."
	icon_state = "hosvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "hosvest_badge"
	icon_nobadge = "hosvest_nobadge"

/obj/item/clothing/suit/storage/vest/hoscoat
	name = "armored coat"
	desc = "A greatcoat enhanced with a special alloy for some protection and style."
	icon_state = "hos"
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|ARMS|LEGS
	flags_inv = HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER

//Jensen cosplay gear
/obj/item/clothing/suit/storage/vest/hoscoat/jensen
	name = "armored trenchcoat"
	desc = "A trenchcoat augmented with a special alloy for some protection and style."
	icon_state = "hostrench"
	flags_inv = HIDEHOLSTER

/obj/item/clothing/suit/storage/vest/pcrc
	name = "PCRC armor vest"
	desc = "A simple kevlar plate carrier belonging to Proxima Centauri Risk Control. This one has a PCRC crest clipped to the chest."
	icon_state = "pcrcvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "pcrcvest_badge"
	icon_nobadge = "pcrcvest_nobadge"

/obj/item/clothing/suit/storage/vest/solgov
	name = "\improper Solar Confederate Government armored vest"
	desc = "A synthetic armor vest. This one is marked with the crest of the Solar Confederate Government."
	icon_state = "solvest"
	armor = list(melee = 40, bullet = 40, laser = 40, energy = 25, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/vest/solgov/heavy
	name = "\improper Solar Confederate Government heavy armored vest"
	desc = "A synthetic armor vest with PEACEKEEPER printed in distinctive blue lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "solwebvest"

/obj/item/clothing/suit/storage/vest/solgov/security
	name = "master at arms heavy armored vest"
	desc = "A synthetic armor vest with MASTER AT ARMS printed in silver lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "secwebvest"

/obj/item/clothing/suit/storage/vest/solgov/command
	name = "command heavy armored vest"
	desc = "A synthetic armor vest with Solar Confederate Government printed in detailed gold lettering on the chest. This one has added webbing and ballistic plates."
	icon_state = "comwebvest"

/obj/item/clothing/suit/storage/vest/tactical //crack at a more balanced mid-range armor, minor improvements over standard vests, with the idea "modern" combat armor would focus on energy weapon protection.
	name = "tactical armored vest"
	desc = "A heavy armored vest in a fetching tan. It is surprisingly flexible and light, even with the extra webbing and advanced ceramic plates."
	icon_state = "tacwebvest"
	item_state = "tacwebvest"
	armor = list(melee = 40, bullet = 40, laser = 60, energy = 35, bomb = 30, bio = 0, rad = 0)

/obj/item/clothing/suit/storage/vest/detective
	name = "detective armor vest"
	desc = "A simple kevlar plate carrier in a vintage brown, it has a badge clipped to the chest that reads, 'Private investigator'."
	icon_state = "detectivevest_nobadge"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	icon_badge = "detectivevest_badge"
	icon_nobadge = "detectivevest_nobadge"

/obj/item/clothing/suit/storage/vest/press
	name = "press vest"
	icon_state = "pvest"
	desc = "A simple kevlar plate carrier. This one has the word 'Press' embroidered on patches on the back and front."
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	allowed = list(/obj/item/device/flashlight,/obj/item/device/taperecorder,/obj/item/weapon/pen,/obj/item/device/camera_film,/obj/item/device/camera,/obj/item/clothing/head/helmet)

/obj/item/clothing/suit/storage/vest/heavy
	name = "heavy armor vest"
	desc = "A heavy kevlar plate carrier with webbing attached."
	icon_state = "webvest"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 50, bullet = 40, laser = 40, energy = 25, bomb = 25, bio = 0, rad = 0)
	slowdown = 0.5

/obj/item/clothing/suit/storage/vest/heavy/officer
	name = "officer heavy armor vest"
	desc = "A heavy kevlar plate carrier with webbing attached. This one has a security holobadge clipped to the chest."
	icon_state = "officerwebvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	icon_badge = "officerwebvest_badge"
	icon_nobadge = "officerwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/warden
	name = "warden heavy armor vest"
	desc = "A heavy kevlar plate carrier with webbing attached. This one has a silver badge clipped to the chest."
	icon_state = "wardenwebvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	icon_badge = "wardenwebvest_badge"
	icon_nobadge = "wardenwebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/hos
	name = "head of security heavy armor vest"
	desc = "A heavy kevlar plate carrier with webbing attached. This one has a gold badge clipped to the chest."
	icon_state = "hoswebvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	icon_badge = "hoswebvest_badge"
	icon_nobadge = "hoswebvest_nobadge"

/obj/item/clothing/suit/storage/vest/heavy/pcrc
	name = "PCRC heavy armor vest"
	desc = "A heavy kevlar plate carrier belonging to Proxima Centauri Risk Control with webbing attached. This one has a PCRC crest clipped to the chest."
	icon_state = "pcrcwebvest_nobadge"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	icon_badge = "pcrcwebvest_badge"
	icon_nobadge = "pcrcwebvest_nobadge"

//Provides the protection of a merc voidsuit, but only covers the chest/groin, and also takes up a suit slot. In exchange it has no slowdown and provides storage.
/obj/item/clothing/suit/storage/vest/heavy/merc
	name = "heavy armor vest"
	desc = "A high-quality heavy kevlar plate carrier in a fetching tan. The vest is surprisingly flexible, and possibly made of an advanced material."
	icon_state = "mercwebvest"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)
	slowdown = 0

//All of the armor below is mostly unused

/obj/item/clothing/suit/armor/centcomm
	name = "CentCom armor"
	desc = "A suit that protects against some damage."
	icon_state = "centcom"
	item_state_slots = list(slot_r_hand_str = "armor", slot_l_hand_str = "armor")
	w_class = ITEMSIZE_LARGE//bulky item
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	allowed = list(/obj/item/weapon/gun/energy,/obj/item/weapon/melee/baton,/obj/item/weapon/handcuffs,/obj/item/weapon/tank/emergency/oxygen,/obj/item/clothing/head/helmet)
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	cold_protection = UPPER_TORSO | LOWER_TORSO | LEGS | FEET | ARMS | HANDS
	min_cold_protection_temperature = SPACE_SUIT_MIN_COLD_PROTECTION_TEMPERATURE
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/heavy
	name = "heavy armor"
	desc = "An old military-grade suit of armor. Incredibly robust against brute force damage! However, it offers little protection from energy-based weapons, which, combined with its bulk, makes it woefully obsolete."
	icon_state = "heavy"
	item_state_slots = list(slot_r_hand_str = "swat", slot_l_hand_str = "swat")
	armor = list(melee = 90, bullet = 80, laser = 10, energy = 10, bomb = 80, bio = 0, rad = 0)
	w_class = ITEMSIZE_HUGE // Very bulky, very heavy.
	gas_transfer_coefficient = 0.90
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	slowdown = 5 // If you're a tank you're gonna move like a tank.
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT|HIDETIE|HIDEHOLSTER
	siemens_coefficient = 0

/obj/item/clothing/suit/armor/tdome
	body_parts_covered = UPPER_TORSO|LOWER_TORSO|LEGS|FEET|ARMS|HANDS
	flags_inv = HIDEGLOVES|HIDESHOES|HIDEJUMPSUIT
	armor = list(melee = 60, bullet = 60, laser = 60, energy = 40, bomb = 40, bio = 0, rad = 0)

/obj/item/clothing/suit/armor/tdome/red
	name = "Thunderdome suit (red)"
	desc = "Reddish armor."
	icon_state = "tdred"
	siemens_coefficient = 1

/obj/item/clothing/suit/armor/tdome/green
	name = "Thunderdome suit (green)"
	desc = "Pukish armor."
	icon_state = "tdgreen"
	siemens_coefficient = 1
