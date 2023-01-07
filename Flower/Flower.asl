state("Flower") {
	uint levelID: 0x008C3DC0, 0x58, 0x70, 0x46A8;
	uint petals: 0x00BCA498, 0x120;
	uint cutsceneOpacity: 0x11AE940;
	uint loading: 0x008FFFB0, 0xF00, 0xDB0, 0x30, 0x858, 0x30, 0x30, 0x498;
}

startup {
	vars.yellow = 47266;
	// vars.red = 4110;
	// vars.fuchsia = 1280;
	// vars.blue = 51456;
	// vars.purple = 14551298;
	vars.pink = 16318976;
	vars.enteredPink = false;
	settings.Add("il", false, "Split after each level finishes (IL Mode)");
}

start {
	if (current.levelID == vars.yellow && (old.petals + 1 == current.petals)) {
		return true;
	}
}

reset {
	if (current.levelID == vars.yellow && current.petals == 0) {
		return true;
	}
}

split {
	if (current.levelID == vars.pink && !vars.enteredPink) {
		vars.enteredPink = true;
		return true;
	}   else if (current.cutsceneOpacity == 1) {
		if (vars.enteredPink || settings["il"]) {
			return true;
		}
	} else if (vars.enteredPink) { // this is probably useless - petals should not be 0 when entering pink
		return false;
	} else if (old.petals + 1 == current.petals && current.petals == 1) {
		return true;
	}
}

isLoading {
	if (current.loading == 1) {
		return true;
	}
	return false;
}