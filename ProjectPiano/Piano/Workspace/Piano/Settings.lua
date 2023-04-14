local settings = {}

Piano = script.Parent
Box = Piano.Keys.KeyBox

--EDIT BELOW----------------------------------------------------------------------
settings.PianoSoundRange = 50

settings.KeyAesthetics = true

settings.PianoSounds = {
	"251400436", --C/C#
	"251427671", --D/D#
	"251427880", --E/F
	"251428187", --F#/G
	"251428448", --G#/A
	"251428570", --A#/B
}

settings.IsCustom = false -- Set this to true if you want modified sounds.

-- Each note takes up exactly 8 seconds in audio. i.e C2 lasts 8 secs, C2# lasts 8 secs, C3 lasts 8 secs, C3# lasts 8 secs etc. for each audio
-- These are the IDs of the piano sounds.

settings.SoundSource = Box

settings.CameraCFrame = CFrame.new(
	(Box.CFrame * CFrame.new(0, 5, 3)).p, -- +z is towards player
	(Box.CFrame * CFrame.new(0, 1, 1)).p
)
-----------------------------------------------------------------------------------

return settings