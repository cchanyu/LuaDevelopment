-- Shuffle music script by Buddyboy105
-- Feel free to edit as you wish!
-- NOTE: You may want to edit the pitch and volume of the sounds.

-- SETTINGS
Numberofsoundz = 10 -- Put the number of Sounds you have inside of the script here

-- THE SCRIPT
math.randomseed(tick()) -- The random number generator! Guaranteed or your money back plus shipping and handling!
for _ = 1, math.huge do -- This basically tells the script to run forever.
	Soundisplaying = (math.random(Numberofsoundz)) -- The variable "Soundisplaying" equals the random number that was generated.
		if Soundisplaying == 1 then -- If the random number = 1, then do the following:
		script.S1:Play() -- Play S1, which is the name of the sound inside of the script.
		wait(244) -- The sound is 97.358 seconds long, so wait 98 seconds.
		elseif Soundisplaying == 2 then -- If the random number does not equal one, and it equals two, do the following:
		script.S2:Play()-- Play S2, which is the name of the sound inside of the script.
		wait(169) -- You should understand this from the previous example.
		elseif Soundisplaying == 3 then -- I assume you understand what this does by now.
		script.S3:Play() -- You probally understand what this does.
		wait(178)
		elseif Soundisplaying == 4 then
		script.S4:Play()
		wait(160)
		elseif Soundisplaying == 5 then
		script.S5:Play()
		wait(136)
		end -- End of the if then statements.
end -- The end of the loop.
-- For more songs just add another elseif statement, another sound in the script, and change the Numberofsoundz.