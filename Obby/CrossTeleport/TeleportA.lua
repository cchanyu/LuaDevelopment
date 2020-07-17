local Teleport = "Teleport-B"
function Touch(hit) --Indicates that the Part has been Touched.
	if script.Parent.Locked == false and script.Parent.Parent:findFirstChild(Teleport).Locked == false then script.Parent.Locked = true script.Parent.Parent:findFirstChild(Teleport).Locked = true --Checks Debounce.
	local Pos = script.Parent.Parent:findFirstChild(Teleport) --Gets the Part to teleport to.
		hit.Parent:moveTo(Pos.Position) wait(1) script.Parent.Locked = false script.Parent.Parent:findFirstChild(Teleport).Locked = false end end --Takes you there and Ends the Function.
script.Parent.Touched:connect(Touch) --Listens out for Touchers.