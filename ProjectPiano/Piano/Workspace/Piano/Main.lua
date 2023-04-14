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

----------------------------------
------------FUNCTIONS-------------
----------------------------------

function Receive(player, action, ...)
	local args = {...}
	if player == User and action == "play" then
		HighlightPianoKey(args[1])
		Connector:FireAllClients("play", User, args[1], Settings.SoundSource.Position, Settings.PianoSoundRange, Settings.PianoSounds, args[2], Settings.IsCustom)
	elseif player == User and action == "abort" then
		Deactivate()
		if SeatWeld then
			SeatWeld:remove()
		end
	end
end
function Activate(player)
	Connector:FireClient(player, "activate", Settings.CameraCFrame, Settings.PianoSounds)
	User = player
end
function Deactivate()
	Connector:FireClient(User, "deactivate")
	User = nil
end

----------------------------------
-----------CONNECTIONS------------
----------------------------------

Connector.OnServerEvent:connect(Receive)

----------------------------------
----------------------------------
----------------------------------
----------SEAT MECHANISM----------
----------------------------------
----------------------------------
----------------------------------

----------------------------------
------------VARIABLES-------------
----------------------------------

Seat = script.Parent.Bench.Seat
SeatWeld = nil


----------------------------------
------------FUNCTIONS-------------
----------------------------------

function WeldChanged(property)
	if property == "Parent" and SeatWeld.Parent == nil then
		SeatWeld = nil
		Deactivate()
		BreakSeatConnections()
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

----------------------------------
-----------CONNECTIONS------------
----------------------------------

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

----------------------------------
------------VARIABLES-------------
----------------------------------

Keys = script.Parent.Keys

----------------------------------
------------FUNCTIONS-------------
----------------------------------

function IsBlack(note)
	if note%12 == 2 or note%12 == 4 or note%12 == 7 or note%12 == 9 or note%12 == 11 then
		return true
	end
end
function HighlightPianoKey(note1)
	if not Settings.KeyAesthetics then return end
	--print("highlight!")
	local octave = math.ceil(note1/12)
	local note2 = (note1 - 1)%12 + 1
	local key = Keys[octave][note2]
	if IsBlack(note1) then
		key.Mesh.Offset = Vector3.new(0.02, -0.15, 0)
	else
		key.Mesh.Offset = Vector3.new(0, -.05, 0)
	end
	delay(.5, function() RestorePianoKey(note1) end)
end
function RestorePianoKey(note1)
	local octave = math.ceil(note1/12)
	local note2 = (note1 - 1)%12 + 1
	local key = Keys[octave][note2]
	if IsBlack(note1) then
		key.Mesh.Offset = Vector3.new(0.02, -0.1, 0)
	else
		key.Mesh.Offset = Vector3.new(0, 0, 0)
	end
end
