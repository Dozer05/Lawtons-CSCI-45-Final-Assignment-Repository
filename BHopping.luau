local player = game.Players.LocalPlayer
local userInputService = game:GetService("UserInputService")

local speedIncrement = 1
local maxSpeed = 32
local baseSpeed = 16
local isHopping = false
local humanoid

local function onKeyPressed(input, gameProcessed)
	if not gameProcessedEvent and (input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D) and humanoid.FloorMaterial == Enum.Material.Air then
		isHopping = true
		while isHopping and humanoid.WalkSpeed < maxSpeed do
			humanoid.WalkSpeed = math.min(humanoid.WalkSpeed + speedIncrement * 4, maxSpeed)
			print(humanoid.WalkSpeed)
			task.wait(0.1)
		end
	end
end

local function onKeyRelease(input)
	if input.KeyCode == Enum.KeyCode.A or input.KeyCode == Enum.KeyCode.D then
		isHopping = false
		local index = 1
		while isHopping == false and humanoid.WalkSpeed > baseSpeed do
			if humanoid.FloorMaterial == Enum.Material.Air then
				humanoid.WalkSpeed = math.max(humanoid.WalkSpeed - speedIncrement / 2, baseSpeed)
				task.wait(0.2)
			else
				humanoid.WalkSpeed = math.max(humanoid.WalkSpeed - speedIncrement / 2 * index, baseSpeed)
				index += 0.25
				task.wait(0.2)
			end
		end
	end
end

local function onCharacterAdded(character)
	humanoid = character:WaitForChild("Humanoid")
	userInputService.InputBegan:Connect(onKeyPressed)
	userInputService.InputEnded:Connect(onKeyRelease)
end

player.CharacterAdded:Connect(onCharacterAdded)

-- for cases when the player joins an existing game apparently idk
if player.Character then
	onCharacterAdded(player.Character)
end