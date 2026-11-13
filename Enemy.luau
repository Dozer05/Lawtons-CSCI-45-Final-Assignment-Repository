local Player = game:GetService("Players")
local NPC = script.Parent
local debounce = false

--Attack
NPC.Humanoid.Touched:Connect(function(hit)
	if hit.Parent:FindFirstChild("Humanoid") and not debounce then --way to specify player?
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player then
			debounce = true
			hit.Parent.Humanoid.Health -= 100
			wait(1)
			debounce = false
		end
	end
end)

--Move
while true do
	local CurrentPlayer = Player:GetPlayers()
	local ClosestRoot
	local ClosestDistance = math.huge
	for i, Player in pairs(CurrentPlayer) do
		local Character = Player.Character
		if Character then
			local PlayerRoot = Character:FindFirstChild("HumanoidRootPart")
			if PlayerRoot then
				local Distance = (NPC.HumanoidRootPart.Position - PlayerRoot.Position).Magnitude
				if Distance < ClosestDistance then
					ClosestRoot = PlayerRoot
					ClosestDistance = Distance
				end
			end
		end
	end
	if ClosestRoot then
		NPC.Humanoid:MoveTo(ClosestRoot.Position)
	end
	wait(0.1)
end
