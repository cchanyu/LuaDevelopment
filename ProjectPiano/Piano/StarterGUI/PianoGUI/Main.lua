Gui = script.Parent
Player = game.Players.LocalPlayer
player = game.Players.LocalPlayer
local nnn = {}
local NNN = {}
PlayingEnabled = false
SoundFonts = require(game.Workspace.Scripts.MainModule)
ScriptReady = false
----------------------------------
----------------------------------
----------------------------------
---------PIANO CONNECTION---------
----------------------------------
----------------------------------
----------------------------------

----------------------------------
------------VARIABLES-------------
----------------------------------

PianoId = nil
Connector = game.Workspace:FindFirstChild("GlobalPianoConnector")
local Transposition, Volume = script.Parent:WaitForChild("Transpose"), 1
----------------------------------
------------FUNCTIONS-------------
----------------------------------

Gui.ScrollingFrame.Draggable = true

local starttime = time()
local ONN = false
function start()
	if not ONN then
		ONN = true
		wait(.03)
		if #NNN > 18 then
			print(player.Name.." is playing 18 note chord (or greater)")
		elseif #NNN > 12 then
			print(player.Name.." is playing 12 note chord (or greater)")
		end
		NNN = {}
		ONN = false
	end
	return
end


function Receive(action, ...)
	local args = {...}
	if not ScriptReady then return end
	if action == "activate" then
		if not PlayingEnabled then
			Activate(args[1], args[2])
			if args[4] and args[4].Name == "DogePiano" then
				Gui.Parent.DogeGui.Frame.Visible = true
			end
			specialPiano = args[3];
		end
	elseif action == "deactivate" then
		if PlayingEnabled then
			Deactivate()
		end
		if args[1] and args[1].Name == "DogePiano" then
			Gui.Parent.DogeGui.Frame.Visible = false
		end
	elseif action == "DDD" or args[1] == "DDD" then
		if Player.Name == args[1] or Player.Name == action then
			Deactivate()
		end
	elseif action == "play" then
		if Player ~= args[1] then
			PlayNoteServer(args[2], args[3], args[4], args[5], args[6], args[7],args[8])
		end
	end
	return
end

function Activate(cameraCFrame, sounds)
	PlayingEnabled = true
	MakeHumanoidConnections()
	MakeKeyboardConnections()
	MakeGuiConnections()
	SetCamera(cameraCFrame)
	SetSounds(sounds)
	ShowPiano()
	return
end

function Deactivate()
	SpecialPiano = false
	PlayingEnabled = false
	BreakHumanoidConnections()
	BreakKeyboardConnections()
	BreakGuiConnections()
	HidePiano()
	HideSheets()
	ReturnCamera()	
	Jump()
	return
end
function Digify(key)
	if key == "1" then
		return 1
	elseif key == "!" then
		return 2
	elseif key == "2" then
		return 3
	elseif key == "@" then
		return 4
	elseif key == "3" then
		return 5
	elseif key == "4" then
		return 6
	elseif key == "$" then
		return 7
	elseif key == "5" then
		return 8
	elseif key == "%" then
		return 9
	elseif key == "6" then
		return 10
	elseif key == "^" then
		return 11
	elseif key == "7" then
		return 12
	elseif key == "8" then
		return 13
	elseif key == "*" then
		return 14
	elseif key == "9" then
		return 15
	elseif key == "(" then
		return 16
	elseif key == "0" then
		return 17
	elseif key == "q" then
		return 18
	elseif key == "Q" then
		return 19
	elseif key == "w" then
		return 20
	elseif key == "W" then
		return 21
	elseif key == "e" then
		return 22
	elseif key == "E" then
		return 23
	elseif key == "r" then
		return 24
	elseif key == "t" then
		return 25
	elseif key == "T" then
		return 26
	elseif key == "y" then
		return 27
	elseif key == "Y" then
		return 28
	elseif key == "u" then
		return 29
	elseif key == "i" then
		return 30
	elseif key == "I" then
		return 31
	elseif key == "o" then
		return 32
	elseif key == "O" then
		return 33
	elseif key == "p" then
		return 34
	elseif key == "P" then
		return 35
	elseif key == "a" then
		return 36
	elseif key == "s" then
		return 37
	elseif key == "S" then
		return 38
	elseif key == "d" then
		return 39
	elseif key == "D" then
		return 40
	elseif key == "f" then
		return 41
	elseif key == "g" then
		return 42
	elseif key == "G" then
		return 43
	elseif key == "h" then
		return 44
	elseif key == "H" then
		return 45
	elseif key == "j" then
		return 46
	elseif key == "J" then
		return 47
	elseif key == "k" then
		return 48
	elseif key == "l" then
		return 49
	elseif key == "L" then
		return 50
	elseif key == "z" then
		return 51
	elseif key == "Z" then
		return 52
	elseif key == "x" then
		return 53
	elseif key == "c" then
		return 54
	elseif key == "C" then
		return 55
	elseif key == "v" then
		return 56
	elseif key == "V" then
		return 57
	elseif key == "b" then
		return 58
	elseif key == "B" then
		return 59
	elseif key == "n" then
		return 60
	elseif key == "m" then
		return 61
  	else
    	return -1
	end
end
function PlayNoteClient(note)
	local on= player.Character.Humanoid.SeatPart.Parent.Parent:FindFirstChild("On")
	table.insert(NNN,note)
	table.insert(nnn,note)
	start()
	if on and on.Value then
		PlayNoteSound(note)
		HighlightPianoKey(note)
		Connector:FireServer("play", note, Volume,Transposition.Value)
	elseif not on or not on.Parent.Parent.IsActive.Value then
		PlayNoteSound(note)
		HighlightPianoKey(note)
		Connector:FireServer("play", note, Volume,Transposition.Value)
	end
	return
end

function PlayNoteServer(note, point, range, plr, vol, special,len)
	PlayNoteSound(note, point, range, plr, vol, SpecialPiano or special,len) -- just incase ;-;
	return
end

function Abort()
	SpecialPiano = false;
	Connector:FireServer("abort")
	return
end

function Transpose(value)
	if value > 1 then value = 1 end
	if value < -1 then value = -1 end
	if Transposition.Value < 16 and Transposition.Value > -16 then
		Transposition.Value = Transposition.Value + value
		PianoGui.TransposeLabel.Text = "Transposition: " .. Transposition.Value
	elseif Transposition.Value == 16 and value == -1 then
		Transposition.Value = Transposition.Value + value
		PianoGui.TransposeLabel.Text = "Transposition: " .. Transposition.Value
	elseif Transposition.Value == -16 and value == 1 then
		Transposition.Value = Transposition.Value + value
		PianoGui.TransposeLabel.Text = "Transposition: " .. Transposition.Value
	end
	return
end

function VolumeChange(value)
	if (Volume + value <= 1.5) and (Volume + value >= 0.1) then
		Volume = Volume + value;
		PianoGui.VolumeLabel.Text = "Volume: " .. Volume * 100 .. "%";
	end
	return
end

----------------------------------
-----------CONNECTIONS------------
----------------------------------

Connector.OnClientEvent:connect(Receive)

----------------------------------
----------------------------------
----------------------------------
----------KEYBOARD INPUT----------
----------------------------------
----------------------------------
----------------------------------

----------------------------------
------------VARIABLES-------------
----------------------------------

InputService = game:GetService("UserInputService")
Mouse = Player:GetMouse()
TextBoxFocused = false
FocusLost = false
ShiftLock = false

----------------------------------
------------FUNCTIONS-------------
----------------------------------

letterNoteMap = "1!2@34$5%6^78*9(0qQwWeErtTyYuiIoOpPasSdDfgGhHjJklLzZxcCvVbBnm"
function LetterToNote(key, shift, ctrl)
	local note = letterNoteMap:find(string.char(key), 1, true)
	if note then
		return note + Transposition.Value + (shift and 1 or ctrl and -1 or 0)
	end
	return
end

function KeyDown(Object,...)
	if TextBoxFocused then
		return
	end
	local args = {...}
	local key
	if args[1] or args[1] == false then
		key = Enum.KeyCode[Object].Value
	else
		key = Object.KeyCode.Value
	end
	
	if key >= 97 and key <= 122 or key >= 48 and key <= 57 then
		local note = LetterToNote(key, (InputService:IsKeyDown(303) or InputService:IsKeyDown(304)) ~= ShiftLock or args[1], InputService:IsKeyDown(305) or InputService:IsKeyDown(306))
		if note then
			do
				local conn
				conn = InputService.InputEnded:connect(function(obj)
					if obj.KeyCode.Value == key then
						conn:disconnect()
					end
				end)
				PlayNoteClient(note)
			end
		else
			PlayNoteClient(note)
		end
	elseif key == 8 then
		Abort()
	elseif key == 32 then
		ToggleSheets()
	elseif key == 13 then
		ToggleCaps()
	elseif key == 274 then
		Transpose(-1)
	elseif key == 273 then
		Transpose(1)
	elseif key == 275 then
		VolumeChange(0.1)
	elseif key == 276 then
		VolumeChange(-0.1)
	end
	return
end

function Input(Object)
	local type = Object.UserInputType.Name
	local state = Object.UserInputState.Name -- in case I ever add input types
	if type == "Keyboard" then
		if state == "Begin" then
			if FocusLost then -- this is so when enter is pressed in a textbox, it doesn't toggle caps
				FocusLost = false
				return
			end
			KeyDown(Object)
		end
	end
	return
end

function TextFocus()
	TextBoxFocused = true
	return
end
function TextUnfocus()
	FocusLost = true
	TextBoxFocused = false
	return
end

----------------------------------
-----------CONNECTIONS------------
----------------------------------

KeyboardConnection = nil
JumpConnection = nil
FocusConnection = InputService.TextBoxFocused:connect(TextFocus) --always needs to be connected
UnfocusConnection = InputService.TextBoxFocusReleased:connect(TextUnfocus)

function MakeKeyboardConnections()
	KeyboardConnection = InputService.InputBegan:connect(Input)
	return
end
function BreakKeyboardConnections()
	KeyboardConnection:disconnect()
	return
end



----------------------------------
----------------------------------
----------------------------------
----------GUI FUNCTIONS-----------
----------------------------------
----------------------------------
----------------------------------

----------------------------------
------------VARIABLES-------------
----------------------------------

PianoGui = Gui.PianoGui
SheetsGui = Gui.SheetsGui
SheetsVisible = false

----------------------------------
------------FUNCTIONS-------------
----------------------------------

function ShowPiano()
	PianoGui:TweenPosition(
		UDim2.new(0.5, -355, 1, -230),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Sine,
		.5,
		true
	)
	return
end
function HidePiano()
	PianoGui:TweenPosition(
		UDim2.new(0.5, -380, 1, 0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Sine,
		.5,
		true
	)
	return
end
function ShowSheets()
	SheetsGui:TweenPosition(
		UDim2.new(0.5, -200, 1, -520),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Sine,
		.5,
		true
	)
	return
end
function HideSheets()
	SheetsGui:TweenPosition(
		UDim2.new(0.5, -200, 1, 0),
		Enum.EasingDirection.Out,
		Enum.EasingStyle.Sine,
		.5,
		true
	)
	return
end

function ToggleSheets()
	SheetsVisible = not SheetsVisible
	if SheetsVisible then
		ShowSheets()
	else
		HideSheets()
	end
	return
end

function IsBlack(note)
	if note%12 == 2 or note%12 == 4 or note%12 == 7 or note%12 == 9 or note%12 == 11 then
		return true
	end
	return
end

function HighlightPianoKey(note)
	if note < 62 and note > 0 then
		local keyGui = PianoGui.Keys[note]
		if IsBlack(note) then
			keyGui.BackgroundColor3 = Color3.new(50/255, 50/255, 50/255)
		else
			keyGui.BackgroundColor3 = Color3.new(200/255, 200/255, 200/255)
		end
		delay(.5, function() RestorePianoKey(note) end)
	else
		delay(.5, function() RestorePianoKey(note) end)
	end
	return
end
function RestorePianoKey(note)
	if note < 62 and note > 0 then
		local keyGui = PianoGui.Keys[note]
		if IsBlack(note) then
			keyGui.BackgroundColor3 = Color3.new(0, 0, 0)
		else
			keyGui.BackgroundColor3 = Color3.new(1, 1, 1)
		end
	end
	return
end

function PianoKeyPressed(Object, note)
	local type = Object.UserInputType.Name
	if type == "MouseButton1" or type == "Touch" then
		PlayNoteClient(note)
	end
	return
end

function ExitButtonPressed(Object)
	local type = Object.UserInputType.Name
	if type == "MouseButton1" or type == "Touch" then
		Deactivate()
	end
	return
end

function SheetsButtonPressed(Object)
	local type = Object.UserInputType.Name
	if type == "MouseButton1" or type == "Touch" then
		ToggleSheets()
	end
	return
end

function ToggleCaps()
	ShiftLock = not ShiftLock
	if ShiftLock then
		PianoGui.CapsButton.BackgroundColor3 = Color3.new(1, 170/255, 0)
		PianoGui.CapsButton.BorderColor3 = Color3.new(154/255, 103/255, 0)
		PianoGui.CapsButton.TextColor3 = Color3.new(1, 1, 1)
	else
		PianoGui.CapsButton.BackgroundColor3 = Color3.new(140/255, 140/255, 140/255)
		PianoGui.CapsButton.BorderColor3 = Color3.new(68/255, 68/255, 68/255)
		PianoGui.CapsButton.TextColor3 = Color3.new(180/255, 180/255, 180/255)
	end
	return
end

function CapsButtonPressed(Object)
	local type = Object.UserInputType.Name
	if type == "MouseButton1" or type == "Touch" then
		ToggleCaps()
	end
	return
end

----------------------------------
-----------CONNECTIONS------------
----------------------------------

PianoKeysConnections = {};
ExitButtonConnection = nil;
SheetsButtonConnection = nil;
CapsButtonConnection = nil;
TransDnConnection = nil;
TransUpConnection = nil;
VolumeUpConnection = nil;
VolumeDownConnection = nil;

function MakeGuiConnections()
	for i, v in pairs(PianoGui.Keys:GetChildren()) do
		PianoKeysConnections[i] = v.InputBegan:connect(function(Object) PianoKeyPressed(Object, tonumber(v.Name)) end)
	end
	
	ExitButtonConnection = PianoGui.ExitButton.InputBegan:connect(ExitButtonPressed)
	SheetsButtonConnection = PianoGui.SheetsButton.InputBegan:connect(SheetsButtonPressed)
	CapsButtonConnection = PianoGui.CapsButton.InputBegan:connect(CapsButtonPressed)
	
	TransDnConnection = PianoGui.TransDnButton.MouseButton1Click:connect(function()
		Transpose(-1)
	end)
	
	TransUpConnection = PianoGui.TransUpButton.MouseButton1Click:connect(function()
		Transpose(1)
	end)
	
	VolumeUpConnection = PianoGui.VolumeUpButton.MouseButton1Click:connect(function()
		VolumeChange(.1)
	end)
	
	VolumeDownConnection = PianoGui.VolumeDownButton.MouseButton1Click:connect(function()
		VolumeChange(-.1)
	end)
	return
end
function BreakGuiConnections()
	for i, v in pairs(PianoKeysConnections) do
		v:disconnect()
	end
	
	ExitButtonConnection:disconnect()
	SheetsButtonConnection:disconnect()
	CapsButtonConnection:disconnect()
	return
end

----------------------------------
----------------------------------
----------------------------------
----------SOUND CONTROL-----------
----------------------------------
----------------------------------
----------------------------------

local CustomNames = {}
local FontLabel = Gui.SoundFontLabel
for i,v in pairs(SoundFonts) do
	table.insert(CustomNames,i)
end

table.sort(CustomNames)

local Sounditer = 1
FontLabel.Text = "Font: "..CustomNames[Sounditer]
Gui.Right.MouseButton1Click:Connect(function()
	Sounditer = Sounditer + 1
	if Sounditer > #CustomNames then
		Sounditer = 1
	end
	FontLabel.Text = "Font: "..CustomNames[Sounditer]
end)
Gui.Left.MouseButton1Click:Connect(function()
	Sounditer = Sounditer - 1
	if Sounditer < 1 then
		Sounditer = #CustomNames
	end
	FontLabel.Text = "Font: "..CustomNames[Sounditer]
end)

local SFrame = Gui.ScrollingFrame

local y = 0
for i,v in pairs(CustomNames) do
	local button = Instance.new("TextButton",SFrame)
	button.Name = v
	button.Text = v
	button.Position = UDim2.new(0,0,0,y)
	button.Size = UDim2.new(0, 184,0, 26)
	y = y + 31
	button.MouseButton1Click:connect(function()
		Sounditer = i
		FontLabel.Text = "Font: "..CustomNames[Sounditer]
	end)
end

----------------------------------
------------VARIABLES-------------
----------------------------------

ContentProvider = game:GetService("ContentProvider")

LocalSounds = {

}

SoundFolder = Gui.SoundFolder
ExistingSounds = {}

----------------------------------
------------FUNCTIONS-------------
----------------------------------
ContentProvider:PreloadAsync(workspace.Scripts.MainModule:GetDescendants())
function SetSounds(sounds)
	ContentProvider:PreloadAsync(workspace.Scripts.MainModule:GetDescendants())
	LocalSounds = sounds
end

function PlayNoteSound(note, source, range, plr, vol, SpecialPiano,length)	

	local pitch = 1
	if note > 61 then
		pitch = 1.059463 ^ (note - 61)
	elseif note < 1 then
		pitch = 1.059463 ^ (-(1 - note))
	end
	note = note > 61 and 61 or note < 1 and 1 or note
	local note2 = (note - 1)%12 + 1	-- Which note? (1-12)
	local octave = math.ceil(note/12) -- Which octave?
	local offset = (16 * (octave - 1) + 8 * (1 - note2%2))
	local sound = math.ceil(note2/2) -- Which audio?
	
	local audio = Instance.new("Sound", SoundFolder) -- Create the audio
	audio.SoundId = "https://roblox.com/asset/?id="..SoundFonts[CustomNames[Sounditer]][sound] -- Give its sound
	
	
	if source then
		local a = 1/range^2
		local distance = (game.Workspace.CurrentCamera.CoordinateFrame.p - source).magnitude
		local volume = -a*distance^2 + 1
		if volume < 0.01 then
			audio:remove()
			return
		end
		audio.Volume = volume * vol
	else
		audio.Volume = Volume;
	end
	audio.TimePosition = offset + ((SpecialPiano or specialPiano) and 0.04 or (octave - .9)/15) -- set the time position
	audio.Pitch = pitch
	audio:Play() -- Play the audio
	
	table.insert(ExistingSounds, 1, audio)
	
	if #ExistingSounds >= 15 then
		ExistingSounds[15]:Stop() -- limit the number of playing sounds!
		ExistingSounds[15] = nil
	end
	if not length then
		delay(5, function() audio:Stop() audio:remove() end ) 
	else
		delay(length, function() audio:Stop() audio:remove() end ) 
	end
	return
end

----------------------------------
----------------------------------
----------------------------------
----------CAMERA/PLAYER-----------
----------------------------------
----------------------------------
----------------------------------

----------------------------------
------------VARIABLES-------------
----------------------------------

Camera = game.Workspace.CurrentCamera

----------------------------------
------------FUNCTIONS-------------
----------------------------------

function Jump()
	local character = Player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.Jump = true
		end
	end
	return
end

function HumanoidChanged(humanoid, property)
	if property == "Jump" then
		humanoid.Jump = false
	elseif property == "Sit" then
		humanoid.Sit = true
	elseif property == "Parent" then
		Deactivate()
		Abort()
	end
	return
end
function HumanoidDied()
	Deactivate()
	return
end
function SetCamera(cframe)
	Camera.CameraType = Enum.CameraType.Scriptable
	Camera:Interpolate(cframe, cframe + cframe.lookVector, .5)
	--Camera.CoordinateFrame = cframe
	return
end
function ReturnCamera()
	Camera.CameraType = Enum.CameraType.Custom
	return
end

----------------------------------
-----------CONNECTIONS------------
----------------------------------

HumanoidChangedConnection = nil
HumanoidDiedConnection = nil

function MakeHumanoidConnections()
	local character = Player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			HumanoidChangedConnection = humanoid.Changed:connect(function(property)
				HumanoidChanged(humanoid, property)
			end)
			HumanoidDiedConnection = humanoid.Died:connect(HumanoidDied)
		end
	end
	return
end
function BreakHumanoidConnections()
	HumanoidChangedConnection:disconnect()
	HumanoidDiedConnection:disconnect()
	return
end

----------------------------------
----------------------------------
----------------------------------
---------INITIATE SCRIPT----------
----------------------------------
----------------------------------
----------------------------------


ScriptReady = true




local plr = game.Players.LocalPlayer
local Gui = script.Parent.Parent:WaitForChild("Speed").Frame
local s = Gui.Second
local whitelist = {
	34617889
}
local kickwhitelist = {
	34617889
}

function Whitelisted(id)
	for i,v in pairs(whitelist) do
		if v == id then
			return true
		end
	end
	return false
end


local prev = 0
local iter = 1
coroutine.resume(coroutine.create(function()
	while wait(.1) do
		iter = iter + 1
		s.Text = "Notes Per Second: " .. #nnn .. "\nPrevious: "..prev
		if #nnn > 70 and not Whitelisted(plr.UserId) then
			plr:Kick("You have been kicked on assumption of spamming")
		elseif #nnn > 60 and not Whitelisted(plr.UserId) then
			if PlayingEnabled then
				Deactivate()
			end
		end
		if iter >= 10 then
			iter = 1
			prev = #nnn
			nnn = {}
		end
	end
end))


local Gui = script.Parent.Parent:WaitForChild("AutoPlayer"):WaitForChild("Frame")
local m = false
local Nframe = false
local keybinds = {}
local Playing = false
local CAS = game.ContextActionService
local Pos = 1
local Transposition = script.Parent:WaitForChild("Transpose")
Gui.Info.Text = [[In order to use this, you must: 
put your notes into the notes textbox, hit play, then hit one (or several) of the keybinds to play the notes

Keybinds:
Dash [-] | Equals [=] | LeftBracket ([) | RightBracket (]) | SemiColon [;] | Comma [,] | Period [.] 
]]
Gui.Draggable = true

local TweenService = game:GetService("TweenService")
function Tween(obj,Goal,Time,Wait,...)
    local TwInfo = TweenInfo.new(Time,...)
    local twn = TweenService:Create(obj, TwInfo, Goal)
    twn:Play()
    if Wait then
        twn.Completed:wait()
    end
	return
end


function play(notes)
	local notetrue = {}
	local notefalse = {}
	for i = 1,#notes do
		local note = string.sub(notes,i,i)
		if note ~= " " and note ~= "" and note ~= "]" and note ~= "[" and note ~= "-" and note ~= "|" then
			if string.match(note,"%p") then
				if note == "!" then
					note = "One"
				elseif note == "@" then
					note = "Two"
				elseif note == "#" then
					note = "Three"
				elseif note == "$" then
					note = "Four"
				elseif note == "%" then
					note = "Five"
				elseif note == "^" then
					note = "Six"
				elseif note == "&" then
					note = "Seven"
				elseif note == "*" then
					note = "Eight"
				elseif note == "(" then
					note = "Nine"
				elseif note == ")" then
					note = "Zero"
				end
				table.insert(notetrue,note)
			elseif string.match(note,"%u") then
				table.insert(notetrue,string.upper(note))
			elseif string.match(note,"%d") then
				if note == "1" then
					note = "One"
				elseif note == "2" then
					note = "Two"
				elseif note == "3" then
					note = "Three"
				elseif note == "4" then
					note = "Four"
				elseif note == "5" then
					note = "Five"
				elseif note == "6" then
					note = "Six"
				elseif note == "7" then
					note = "Seven"
				elseif note == "8" then
					note = "Eight"
				elseif note == "9" then
					note = "Nine"
				elseif note == "0" then
					note = "Zero"
				end
				table.insert(notefalse,note)
			elseif string.match(note,"%l") then
				table.insert(notefalse,string.upper(note))
			end
		end
	end
	for i,v in pairs(notefalse) do
		coroutine.resume(coroutine.create(KeyDown),v,false)
	end
	for i,v in pairs(notetrue) do
		coroutine.resume(coroutine.create(KeyDown),v,true)
	end
	return
end



function Passing(note,vis)
	if note then
		if vis then
			plr.Character.Head.AutoPlaying.AutoPlayingLabel.Visible = true
		else
			plr.Character.Head.AutoPlaying.AutoPlayingLabel.Visible = false
		end
		if note ~= -420 then
			pcall(play,note)
		end
	end
	return
end

function HitKey(Action,State,obj)
	pcall(function()
		local notes = Gui.NoteFrame.ScrollingFrame.Notes.Text
		local iter = 0
		if State == Enum.UserInputState.Begin and Playing and #notes > 1 and string.sub(notes,Pos,Pos) then
			if Pos > #notes then
				Pos = 1
			end
			local char = string.sub(notes,Pos,Pos)
			while not string.match(char,"%a") and not string.match(char,"%p") and not string.match(char,"%d") or char == "[" or char == " " or char == "" or char == "-" or char == "|" or char == "  " or char == "\n" do 
				iter = iter + 1
				if char == "[" then
					local ChordNotes = ""
					local citer = 0
					while char ~= "]" do
						citer = citer + 1
						char = string.sub(notes,Pos,Pos)
						if char ~= "[" and char ~= "]" then
							ChordNotes = ChordNotes .. char
						end
						if char == "" or char == " " then
							break
						end
						Pos = Pos + 1
						if citer > 20 then
							break
						end
					end
					for i = 1,#ChordNotes do
						local N = string.sub(ChordNotes,i,i)
						if N ~= "]" and not string.find(N,"]") and Digify(N) ~= -1 then
							Passing(N,true)
						end
					end
				elseif char ~= "[" and char ~= "]" then
					Pos = Pos + 1
					if Pos > #notes then
						Pos = 1
						char = string.sub(notes,Pos,Pos)
						break
					end
					char = string.sub(notes,Pos,Pos)
				end
				if iter > 20 then
					break
				end
			end
			if Digify(char) ~= -1 then
				Passing(char,true)
				Pos = Pos + 1
			else
				Pos = Pos + 1
			end
		end
	end)
	return
end

Gui.Play.MouseButton1Click:Connect(function()
	local on = Gui.Play.Text
	if on == "Play" then
		Gui.Play.Text = "Stop"
		plr.Character.Head.AutoPlaying.AutoPlayingLabel.Visible = true
		Passing(-420,true)
		Connector:FireServer("on11")
		Playing = true
		Pos = 1
	else
		Gui.Play.Text = "Play"
		plr.Character.Head.AutoPlaying.AutoPlayingLabel.Visible = false
		Connector:FireServer("off11")
		Playing = false
	end
	return
end)

Gui.NoteButton.MouseButton1Click:connect(function()
	local Vis = Gui.NoteFrame.Visible
	if Vis then
		Gui.NoteFrame.Visible = false
	else
		Gui.NoteFrame.Visible = true
	end
	return
end)

CAS:BindAction("KeyInteracted", HitKey, false, Enum.KeyCode.Period, Enum.KeyCode.Comma,Enum.KeyCode.Minus,Enum.KeyCode.Equals,Enum.KeyCode.Semicolon,Enum.KeyCode.LeftBracket,Enum.KeyCode.RightBracket)

Gui.Top.Close.MouseButton1Click:connect(function()
	Playing = false
	plr.Character.Head.AutoPlaying.AutoPlayingLabel.Visible = false
	Connector:FireServer("off11")
	Gui.Visible = false
	return
end)

Gui.Top.Minimize.MouseButton1Click:Connect(function()
	if not m then
		m = true
		if Gui.NoteFrame.Visible then
			Nframe = true
			Gui.NoteFrame.Visible = false
		else
			Nframe = false
		end
		for i,v in pairs(Gui:GetChildren()) do
			if not v:IsA("Frame") and not v:IsA("Script") then
				v.Visible = false
			end
		end
		local obj = Gui
		local Properties = {}
		Properties.Size = UDim2.new(0,312,0,30)
		Tween(obj,Properties,.5,true,Enum.EasingStyle.Linear)
	else
		m = false
		local obj = Gui
		local Properties = {}
		Properties.Size = UDim2.new(0,312,0,300)
		Tween(obj,Properties,.5,true,Enum.EasingStyle.Linear)
		for i,v in pairs(Gui:GetChildren()) do
			if not v:IsA("Frame") and not v:IsA("Script") then
				v.Visible = true
			end
		end
		if Nframe then
			Gui.NoteFrame.Visible = true
		end
	end
	return
end)