# Autosplitter for *Journey*


## Features
Starts / resets the timer when selecting *Yes* after pressing *Chapter Select* in the option menu. \
Splits when entering the next level. The final split occurs after you reach the coordinates past which you lose control in Paradise.

## Usage
Start Journey and LiveSplit. Now press *Start* and select *Chapter Select* --> *Yes*. \
The splitter has now found the pointer path it needs and is ready for operation until you close the game. \
Return to CS a second time and the timer will start.


### Settings:
Settings are available in Livesplit by right clicking and selecting *Edit Layout* --> *Layout Settings* --> *Scriptable Auto Splitter*.

***Pause between tries to locate CS Pointer*** - Checking this option sets the delay between tries to find the pointer path \
to 1 second instead of 10 milliseconds. Good if you have a weak CPU.

***Wait for 3 seconds before starting the pointer initialization*** - Waits an additional 3 seconds \
before starting the search for the pointer path. Might get the timer to work if it didn't start before.

***Don't split at the end of Paradise (Co-op mode)*** - Does not split when going through the light in Paradise. \
Useful if you are running with a companion and want to manually split when the last of you finishes.

### My timer does not start!
Try starting the timer after you have already started Journey.\
If it still doesn't work, you can ask in the *#speedrun* channel of the below Discord, \
or ping me (*arckoor*) directly.

### Known Limitations
- You need to manually save after the run ends. The timer won't restart when teleporting to CS if you don't do this. 
- If you got a gold split (but didn't finish the run yet) and teleport to Chapter Select, the timer will reset and save this gold split! \
Reset the timer manually before to avoid saving a gold split by mistake if you don't want to.
- When pressing *Continue* in Main Menu, the timer will reset and start from 0 at whatever level it is you enter (it will not split when entering portals in Chapter Select however).
- The timer starts on average between 1 to 3 frames after selecting *Yes* at 55 FPS, when teleporting to CS. (maximum of 0.05 seconds of delay)

## Links and stuff
Leaderboards: *[https://www.speedrun.com/Journey](https://www.speedrun.com/Journey)* \
Discord: *[https://discord.gg/TG6GMq4Cyg](https://discord.gg/TG6GMq4Cyg)*