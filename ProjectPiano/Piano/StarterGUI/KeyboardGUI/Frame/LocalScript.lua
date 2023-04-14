local frame = script.Parent
local n
local notes = {}
local iter = 1
wait(.2)
Connector = game.Workspace:FindFirstChild("GlobalPianoConnector")

function main(N,convert,key)
	pcall(function()
		if convert then
			--Conversion from sheet to table
			notes = {}
			iter = 1
			local chord = false
			local chordchars = ""
			N = string.gsub(N,"\n","")
			N = string.gsub(N," ","")
			N = string.gsub(N,"-","")
			N = string.gsub(N,"|","")
			for i = 1,#N do
				local char = string.sub(N,i,i)
				if char and char ~= "" and char ~= "-" and char ~= "|" and char ~= " " and char ~= "\n" and char ~= "{" and char ~= "}" and char ~= [[
					]] then
					if char ~= "[" and not chord then
						table.insert(notes,char)
					elseif char == "]" and chord then
						chord = false
						table.insert(notes,chordchars)
						chordchars = ""
					elseif char == "[" and not chord then
						chord = true
					elseif chord then
						chordchars = chordchars .. char
						if string.sub(N,i-1,i-1) == " " then
							break
						end
					else
						print('I don\'t know what to do with '..char..'\nFunction 6 in the main script for the gui')
					end
				end
			end
			if chordchars ~= "" then
				notes = {}
				chordchars = ""
				iter = 1
				frame["On/Off"].Text = "Off"
				Connector:FireServer("Light",true,"a",true)
				--print('sent Light ALPHA!') --debug
				print('ERROR, there seems to have been an open chord (parenthessis)\nOr there seems to be a space inside of a chord')
				return
			else
				Connector:FireServer("Light",true,notes[iter])
				--print('sent Light BETA!') --debug
			end
		elseif not convert and #notes > 0 then
			local new = ""
			local chars = notes[iter]
			for i = 1,#chars do
				local char = string.sub(chars,i,i)
				if char ~= key and char and char ~= " " then
					new = new .. char
				else
					Connector:FireServer("Light",false,char)
					--print('sent Light GAMMA!') --debug
				end
			end
			notes[iter] = new
			if new == "" or new == " " or not new then
				iter = iter + 1
				if notes[iter] and notes[iter] ~= "" then
					Connector:FireServer("Light",true,notes[iter])
					--print('sent Light DELTA!') --debug
					wait(.05)
					Connector:FireServer("Light",true,notes[iter])
					--print('sent Light EPSILON!') --debug
				else
					n = frame.NoteFrame.ScrollingFrame.TextBox.Text
					main(n,true)
					iter = 1
					Connector:FireServer("Light",true,notes[iter])
					--print('sent Light ZETA!') --debug
				end
			end
		end
	end)
	return
end

frame.SheetToggle.MouseButton1Click:Connect(function()
	local thing = frame.NoteFrame
	if thing.Visible then
		thing.Visible = false
	else
		thing.Visible = true
	end
end)

frame["On/Off"].MouseButton1Click:connect(function()
	local thing = frame["On/Off"]
	if thing.Text == "Off" then
		iter = 1
		thing.Text = "On"
		n = frame.NoteFrame.ScrollingFrame.TextBox.Text
		main(n,true)
	else
		thing.Text = "Off"
		Connector:FireServer("Light",true,"a",true)
		print('sent Light ETA!') --debug
	end
end)

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

function Receive(action, ...)
	local args = {...}
	if action == "play" and frame["On/Off"].Text == "On" and frame.Visible and args[1] == game.Players.LocalPlayer then
		main(nil,false,UnDigify(args[2]))
	end
	return
end

Connector.OnClientEvent:connect(Receive)