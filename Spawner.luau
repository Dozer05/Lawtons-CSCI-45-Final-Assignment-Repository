local Enemies = game.ReplicatedStorage:WaitForChild("EnemyFolder")
local Spawner = script.Parent
local SpawnTime = 3

while wait(SpawnTime) do
	local Max = Enemies:GetChildren()
	if #Max == 0 then continue end
	local Enemy = Max[math.random(1, #Max)]:Clone()
	Enemy.HumanoidRootPart.CFrame = Spawner.CFrame
	Enemy.Parent = workspace
end
