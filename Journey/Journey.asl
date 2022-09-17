state("Journey") {
	// These pointer paths are from Paleologos' cheat table
	// https://discord.com/channels/295204028881698816/298224711513669643/794314261676556308
	uint levelID: 0x03CFCA80, 0x70, 0x28, 0xD0, 0x100, 0x30, 0x368, 0x30;
	float posX: 0x03C47B18, 0x60, 0x28, 0xD0, 0x100, 0x30, 0x370, 0xC0;
	float posY: 0x03C47B18, 0x70, 0x178, 0x78, 0xD0, 0x108, 0x3A8, 0xC4;
	float posZ: 0x03C47B18, 0x70, 0x28, 0xD0, 0x108, 0x30, 0x370, 0xC8;
}

startup {
	settings.Add("sleepForCS", true, "Pause between tries to locate CS Pointer");
	settings.Add("safeStartUp", true, "Wait for 3 seconds before starting the pointer initialization");
}

init {
	vars.resetEnabled = true;
	vars.splitsEnabled = true;
	vars.csaddr = IntPtr.Zero;
	vars.CancelSource = new CancellationTokenSource();
	int delay = settings["safeStartUp"] ? 3000 : 1000;
	System.Threading.Thread.Sleep(delay);

	System.Threading.Tasks.Task.Run(async () => {
		int sleep = settings["sleepForCS"] ? 1000 : 10;

		TaskStart: 
			try {
				IntPtr addr = IntPtr.Zero;
				DeepPointer ptr = new DeepPointer(0x018D2178, 0x560, 0x258, 0x2218, 0x48, 0xD4);
				while (addr == IntPtr.Zero) {
					if (vars.CancelSource.IsCancellationRequested) {
						break;
					}
					ptr.DerefOffsets(game, out addr);
					await System.Threading.Tasks.Task.Delay(sleep);
				}
				vars.csaddr = addr;
			} catch (Exception e) {
				System.Threading.Tasks.Task.Delay(sleep);
				goto TaskStart;
			}
	});
}

update {
	if (vars.csaddr == IntPtr.Zero) {
		return false;
	}
	current.cSelect = game.ReadValue<uint>((IntPtr)vars.csaddr);
	if (current.cSelect == 0 && !vars.resetEnabled) {
		vars.resetEnabled = true;
	}
}

start {
	if (current.cSelect != 0) {
		return true; 
	}
}

reset {
	if (current.cSelect != 0 && vars.resetEnabled) {
		vars.resetEnabled = false;
		vars.splitsEnabled = false;
		System.Threading.Tasks.Task.Delay(5000).ContinueWith(t => vars.splitsEnabled = true);
		return true;
	}
}

split {
	if (vars.splitsEnabled) {
		if (current.levelID - 1 == old.levelID) {
			return true;
		} else if (
			current.levelID == 7 && 
			current.posZ >= 993.1323 &&
			current.posX >= 218.0 &&
			current.posX <= 295.0 &&
			current.posY <= 770.0
		) {
			return true;
		}
	}
}

exit {
	vars.CancelSource.Cancel();
}

shutdown {
    vars.CancelSource.Cancel();
}