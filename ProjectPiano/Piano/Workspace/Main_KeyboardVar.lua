Settings = require(script.Parent.Settings)
Piano = script.Parent
Box = Piano.Keys.KeyBox

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

User = nil

Connector = game.Workspace:FindFirstChild("GlobalPianoConnector")
if not Connector or not Connector:IsA("RemoteEvent") then
	error("The piano requires a RemoteEvent named GlobalPianoConnector to be in Workspace.")
end
local frame = nil
local SheetsActive = false
----------------------------------
------------FUNCTIONS-------------
----------------------------------

function Receive(player, action, ...)
	local args = {...}
	if player == User and action == "play" then
		Connector:FireAllClients("play", User, args[1], Settings.SoundSource.Position, Settings.PianoSoundRange, Settings.PianoSounds, args[2], Settings.IsCustom)
		HighlightPianoKey(args[1],args[3]) --don't want the note to snap
		--HighlightPianoKey((args[1] > 61 and 61) or (args[1] < 1 and 1) or args[1],args[3]) gives note snapped to range of 1-61, transpose.value
	elseif player == User and action == "abort" then
		Deactivate()
		if SeatWeld then
			SeatWeld:remove()
		end
	elseif player == User and action == "Light" then
		if args[3] then
			reset()
			SheetsActive = false
		else
			if args[1] then
				SheetsActive = true
				LightUp(args[2])
			elseif not args[1] then
				DeLight(args[2])
			end
		end
	end
end



function Activate(player)
	Connector:FireClient(player, "activate", Settings.CameraCFrame, Settings.PianoSounds, true)
	User = player
	frame = player.PlayerGui:FindFirstChild("KeyboardGuiThing")
	if not frame then
		print("ERROR, There is no gui for the piano, go to line 44 of main to view error")
		Deactivate()
	else
		frame.Enabled = true
		reset()
	end
end

function Deactivate()
	if User and User.Parent then
		Connector:FireClient(User, "deactivate")
		User.Character:SetPrimaryPartCFrame(Box.CFrame + Vector3.new(0, 5, 0))
	end
	if frame then
		frame.Enabled = false
		reset()
	end
	frame = nil
	User = nil
end

Connector.OnServerEvent:connect(Receive)

----------------------------------
----------------------------------
----------------------------------
----------SEAT MECHANISM----------
----------------------------------
----------------------------------
----------------------------------

Seat = script.Parent.Bench.Seat
SeatWeld = nil

function WeldChanged(property)
	if property == "Parent" and SeatWeld.Parent == nil then
		SeatWeld = nil
		Deactivate()
		BreakSeatConnections()
		Piano.Bench.Seat.Disabled = true
		wait(1)
		Piano.Bench.Seat.Disabled = false
	end
end
function ChildAdded(child)
	if child:IsA("Weld") then
		local root = child.Part1
		local character = root.Parent
		local player = game.Players:GetPlayerFromCharacter(character)
		if player then
			SeatWeld = child
			Activate(player)
			MakeSeatConnections()
		end
	end
end

SeatWeldConnection = nil

function MakeSeatConnections()
	SeatWeldConnection = SeatWeld.Changed:connect(WeldChanged)
end
function BreakSeatConnections()
	SeatWeldConnection:disconnect()
end

Seat.ChildAdded:connect(ChildAdded)

----------------------------------
----------------------------------
----------------------------------
------------AESTHETICS------------
----------------------------------
----------------------------------
----------------------------------

Keys = script.Parent.Keys



function IsBlack(note)
	if note%12 == 2 or note%12 == 4 or note%12 == 7 or note%12 == 9 or note%12 == 11 then
		return true
	end
end

function UnDigify(digit)
	if digit < 1 or digit > 61 then
		return ""
	elseif digit == 1 then
		return "1"
	elseif digit == 2 then
		return "!"
	elseif digit == 3 then
		return "2"
	elseif digit == 4 then
		return "@"
	elseif digit == 5 then
		return "3"
	elseif digit == 6 then
		return "4"
	elseif digit == 7 then
		return "$"
	elseif digit == 8 then
		return "5"
	elseif digit == 9 then
		return "%"
	elseif digit == 10 then
		return "6"
	elseif digit == 11 then
		return "^"
	elseif digit == 12 then
		return "7"
	elseif digit == 13 then
		return "8"
	elseif digit == 14 then
		return "*"
	elseif digit == 15 then
		return "9"
	elseif digit == 16 then
		return "("
	elseif digit == 17 then
		return "0"
	elseif digit == 18 then
		return "q"
	elseif digit == 19 then
		return "Q"
	elseif digit == 20 then
		return "w"
	elseif digit == 21 then
		return "W"
	elseif digit == 22 then
		return "e"
	elseif digit == 23 then
		return "E"
	elseif digit == 24 then
		return "r"
	elseif digit == 25 then
		return "t"
	elseif digit == 26 then
		return "T"
	elseif digit == 27 then
		return "y"
	elseif digit == 28 then
		return "Y"
	elseif digit == 29 then
		return "u"
	elseif digit == 30 then
		return "i"
	elseif digit == 31 then
		return "I"
	elseif digit == 32 then
		return "o"
	elseif digit == 33 then
		return "O"
	elseif digit == 34 then
		return "p"
	elseif digit == 35 then
		return "P"
	elseif digit == 36 then
		return "a"
	elseif digit == 37 then
		return "s"
	elseif digit == 38 then
		return "S"
	elseif digit == 39 then
		return "d"
	elseif digit == 40 then
		return "D"
	elseif digit == 41 then
		return "f"
	elseif digit == 42 then
		return "g"
	elseif digit == 43 then
		return "G"
	elseif digit == 44 then
		return "h"
	elseif digit == 45 then
		return "H"
	elseif digit == 46 then
		return "j"
	elseif digit == 47 then
		return "J"
	elseif digit == 48 then
		return "k"
	elseif digit == 49 then
		return "l"
	elseif digit == 50 then
		return "L"
	elseif digit == 51 then
		return "z"
	elseif digit == 52 then
		return "Z"
	elseif digit == 53 then
		return "x"
	elseif digit == 54 then
		return "c"
	elseif digit == 55 then
		return "C"
	elseif digit == 56 then
		return "v"
	elseif digit == 57 then
		return "V"
	elseif digit == 58 then
		return "b"
	elseif digit == 59 then
		return "B"
	elseif digit == 60 then
		return "n"
	elseif digit == 61 then
		return "m"
  	else
    	return "?"
	end
end

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

function LightUp(keys)
	pcall(function()
		if keys and keys ~= "" then
			for i = 1,#keys do
				local char = string.sub(keys,i,i)
				if char then
					local upper = false
					if string.match(char,"%p") then
						upper = true
						if char == "!" then
							char = "1"
						elseif char == "@" then
							char = "2"
						elseif char == "#" then
							char = "3"
						elseif char == "$" then
							char = "4"
						elseif char == "%" then
							char = "5"
						elseif char == "^" then
							char = "6"
						elseif char == "&" then
							char = "7"
						elseif char == "*" then
							char = "8"
						elseif char == "(" then
							char = "9"
						elseif char == ")" then
							char = "0"
						end
					elseif string.match(char,"%u") then
						upper = true
						char = string.lower(char)
					end
					local key = Piano.Case.Keyboard.Keys:FindFirstChild(char)
					local shift = Piano.Case.Keyboard.Keys.Shift --shift key
					if key then
						local obj = key
						local Properties = {}
						key.Material = "Neon"
						if upper then
							shift.Material = "Neon" --shift key
							Properties.Color = Color3.fromRGB(117, 83, 255)
							Tween(obj,Properties,.1,false,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
							Tween(shift,Properties,.1,false,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false) --shift key
							shift.Material = "Neon" --san check
						else
							Properties.Color = Color3.fromRGB(123, 186, 244)
							Tween(obj,Properties,.1,false,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
						end
						key.Material = "Neon" --san check
						--print("lighting",key)
					end
				end
			end
		end
	end)
	return
end

function reset()
	for i,v in pairs(Piano.Case.Keyboard.Keys:GetChildren()) do
		local obj = v
		local Properties = {}
		Properties.Color = Color3.fromRGB(27, 42, 53)
		Tween(obj,Properties,.1,false,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
		v.Material = "SmoothPlastic"
	end
	return
end

function DeLight(char)
	pcall(function()
		if char and char ~= " " then
			local upper = false
			if string.match(char,"%p") then
				upper = true
				if char == "!" then
					char = "1"
				elseif char == "@" then
					char = "2"
				elseif char == "#" then
					char = "3"
				elseif char == "$" then
					char = "4"
				elseif char == "%" then
					char = "5"
				elseif char == "^" then
					char = "6"
				elseif char == "&" then
					char = "7"
				elseif char == "*" then
					char = "8"
				elseif char == "(" then
					char = "9"
				elseif char == ")" then
					char = "0"
				end
			elseif string.match(char,"%u") then
				upper = true
				char = string.lower(char)
			end
			local key = Piano.Case.Keyboard.Keys:FindFirstChild(char)
			local shift = Piano.Case.Keyboard.Keys.Shift --shift key
			if key then
				local obj = key
				local Properties = {}
				Properties.Color = Color3.fromRGB(27, 42, 53)
				if upper then
					Tween(obj,Properties,.1,false,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
					Tween(shift,Properties,.1,false,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false) --shift key
					shift.Material = "SmoothPlastic" --san check
				else
					Tween(obj,Properties,.1,false,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
				end
				key.Material = "SmoothPlastic"
				--print("delighting",key)
			end
		end
	end)
	return
end

reset()

shifting = false --debounce for shift key

function keyTween(key,property) --new function to highlight a key
	local prop = property --do not overwrite original properties
	local simulTween = coroutine.wrap(function(key,prop) --coroutine to allow highlighting shift alongside key
		key.Material = "Neon"
		Tween(key,prop,.1,true,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
		prop.Color = Color3.fromRGB(27, 42, 53)
		key.Material = "Neon" --san check
		Tween(key,prop,.1,true,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
		key.Material = "SmoothPlastic"
		if shifting then
			shifting = false --shift key debounce
		end
	end)
	simulTween(key,prop)
end

function HighlightPianoKey(note1,transpose)
	if not Settings.KeyAesthetics then return end
	note1 = note1-transpose --return note1 to original key. but bad at detecting ctrl
	local octave = math.ceil(note1/12)
	local note2 = (note1 - 1)%12 + 1
	local letter = UnDigify(note1)
	local upper = false
	if string.match(letter,"%p") then
		upper = true
		if letter == "!" then
			letter = "1"
		elseif letter == "@" then
			letter = "2"
		elseif letter == "#" then
			letter = "3"
		elseif letter == "$" then
			letter = "4"
		elseif letter == "%" then
			letter = "5"
		elseif letter == "^" then
			letter = "6"
		elseif letter == "&" then
			letter = "7"
		elseif letter == "*" then
			letter = "8"
		elseif letter == "(" then
			letter = "9"
		elseif letter == ")" then
			letter = "0"
		end
	elseif string.match(letter,"%u") then
		upper = true
		letter = string.lower(letter)
	end
	local key = Piano.Case.Keyboard.Keys:FindFirstChild(letter)
	local shift = Piano.Case.Keyboard.Keys.Shift --shift key
	
	--rewrite
	
	if key then
		local obj = key
		local Properties = {}
		
		if not SheetsActive then
			if upper then
				Properties.Color = Color3.fromRGB(117, 83, 255)
				keyTween(obj,Properties)
				if not shifting then --check if shift currently tweening
					keyTween(shift,Properties)
					shifting = true --shift key debounce
				end
			else
				Properties.Color = Color3.fromRGB(123, 186, 244)
				keyTween(obj,Properties)
			end
		elseif SheetsActive then
			if key.BrickColor.Name == "Black" then
				if upper then
					Properties.Color = Color3.fromRGB(117, 83, 255)
					keyTween(obj,Properties)
					if not shifting then --check if shift currently tweening
						keyTween(shift,Properties)
						shifting = true --shift key debounce
					end
				else
					Properties.Color = Color3.fromRGB(123, 186, 244)
					keyTween(obj,Properties)
				end
			end
		end
	end
	return
end

	--the old script
	
--	if key then
--		if not SheetsActive then
--			local obj = key
--			local Properties = {}
--			key.Material = "Neon"
--			if upper then
--				Properties.Color = Color3.fromRGB(117, 83, 255)
--				Tween(obj,Properties,.1,true,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
--			else
--				Properties.Color = Color3.fromRGB(123, 186, 244)
--				Tween(obj,Properties,.1,true,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
--			end
--			key.Material = "Neon"
--			Properties.Color = Color3.fromRGB(27, 42, 53)
--			Tween(obj,Properties,.1,true,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
--			key.Material = "SmoothPlastic"
--		elseif SheetsActive then
--			if key.BrickColor.Name == "Black" then
--				local obj = key
--				local Properties = {}
--				key.Material = "Neon"
--				if upper then
--					Properties.Color = Color3.fromRGB(117, 83, 255)
--					Tween(obj,Properties,.5,true,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
--				else
--					Properties.Color = Color3.fromRGB(123, 186, 244)
--					Tween(obj,Properties,.1,true,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
--				end
--				key.Material = "Neon"
--				Properties.Color = Color3.fromRGB(27, 42, 53)
--				Tween(obj,Properties,.1,true,Enum.EasingStyle.Linear,Enum.EasingDirection.Out,0,false)
--				key.Material = "SmoothPlastic"
--			end
--		end
--	end