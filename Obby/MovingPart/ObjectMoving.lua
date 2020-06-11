local part = script.Parent

while true do
	for i = 1,1 do
		part.Position = part.Position + Vector3.new(0,-1,0)
	wait(1)
	end
	for i = 1,1 do
		part.Position = part.Position + Vector3.new(0,1,0)
	wait(1)
	end
end