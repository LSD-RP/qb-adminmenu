

-- local IsNoClipping      = false
-- local PlayerPed         = nil
-- local NoClipEntity      = nil
-- local Camera            = nil
-- local NoClipAlpha       = nil
-- local PlayerIsInVehicle = false
-- local ResourceName      = GetCurrentResourceName()

-- local MinY, MaxY        = -89.0, 89.0

-- --[[
--         Configurable values are commented.
-- ]]

-- -- Perspective values
-- local PedFirstPersonNoClip      = false      -- No Clip in first person when not in a vehicle
-- local VehFirstPersonNoClip      = false      -- No Clip in first person when in a vehicle

-- -- Speed settings
-- local Speed                     = 1         -- Default: 1
-- local MaxSpeed                  = 16.0      -- Default: 16.0

-- -- Key bindings
-- local MOVE_FORWARDS             = 32        -- Default: W
-- local MOVE_BACKWARDS            = 33        -- Default: S
-- local MOVE_LEFT                 = 34        -- Default: A
-- local MOVE_RIGHT                = 35        -- Default: D
-- local MOVE_UP                   = 44        -- Default: Q
-- local MOVE_DOWN                 = 46        -- Default: E

-- local SPEED_DECREASE            = 14        -- Default: Mouse wheel down
-- local SPEED_INCREASE            = 15        -- Default: Mouse wheel up
-- local SPEED_RESET               = 348       -- Default: Mouse wheel click
-- local SPEED_SLOW_MODIFIER       = 36        -- Default: Left Control
-- local SPEED_FAST_MODIFIER       = 21        -- Default: Left Shift
-- local SPEED_FASTER_MODIFIER     = 19        -- Default: Left Alt


-- local DisabledControls = function()
--     HudWeaponWheelIgnoreSelection()
--     DisableAllControlActions(0)
--     DisableAllControlActions(1)
--     DisableAllControlActions(2)
--     EnableControlAction(0, 220, true)
--     EnableControlAction(0, 221, true)
--     EnableControlAction(0, 245, true)
-- end

-- local IsControlAlwaysPressed = function(inputGroup, control)
--     return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control)
-- end

-- local IsPedDrivingVehicle = function(ped, veh)
--     return ped == GetPedInVehicleSeat(veh, -1)
-- end

-- local SetupCam = function(coords, rotation)
--     local entityRot = GetEntityRotation(NoClipEntity)
--     Camera = CreateCameraWithParams("DEFAULT_SCRIPTED_CAMERA", GetEntityCoords(NoClipEntity), vector3(0.0, 0.0, entityRot.z), 75.0)
--     SetCamActive(Camera, true)
--     RenderScriptCams(true, true, 1000, false, false)

--     if PlayerIsInVehicle == 1 then
--         AttachCamToEntity(Camera, NoClipEntity, 0.0, VehFirstPersonNoClip == true and 0.5 or -4.5, VehFirstPersonNoClip == true and 1.0 or 2.0, true)
--     else
--         AttachCamToEntity(Camera, NoClipEntity, 0.0, PedFirstPersonNoClip == true and 0.0 or -2.0, PedFirstPersonNoClip == true and 1.0 or 0.5, true)
--     end

-- end

-- local DestroyCamera = function(entity)
--     SetGameplayCamRelativeHeading(0)
--     RenderScriptCams(false, true, 1000, true, true)
--     DetachEntity(NoClipEntity, true, true)
--     SetCamActive(Camera, false)
--     DestroyCam(Camera, true)
-- end

-- local GetGroundCoords = function(coords)
--     local rayCast               = StartShapeTestRay(coords.x, coords.y, coords.z, coords.x, coords.y, -10000.0, 1, 0)
--     local _, hit, hitCoords     = GetShapeTestResult(rayCast)
--     return (hit == 1 and hitCoords) or coords
-- end

-- local CheckInputRotation = function()
--     local rightAxisX = GetControlNormal(0, 220)
--     local rightAxisY = GetControlNormal(0, 221)

--     local rotation = GetCamRot(Camera, 2)

--     local yValue = rightAxisY * -5
--     local newX
--     local newZ = rotation.z + (rightAxisX * -10)
--     if (rotation.x + yValue > MinY) and (rotation.x + yValue < MaxY) then
--         newX = rotation.x + yValue
--     end
--     if newX ~= nil and newZ ~= nil then
--         SetCamRot(Camera, vector3(newX, rotation.y, newZ), 2)
--     end
    
--     SetEntityHeading(NoClipEntity, math.max(0, (rotation.z % 360)))        
-- end

-- RunNoClipThread = function()
--     Citizen.CreateThread(function()
--         while IsNoClipping do
--             Citizen.Wait(0)
--             CheckInputRotation()
--             DisabledControls()

--             if IsControlAlwaysPressed(2, SPEED_DECREASE) then
--                 Speed = Speed - 0.5
--                 if Speed < 0.5 then
--                     Speed = 0.5
--                 end
--             elseif IsControlAlwaysPressed(2, SPEED_INCREASE) then
--                 Speed = Speed + 0.5
--                 if Speed > MaxSpeed then
--                     Speed = MaxSpeed
--                 end
--             elseif IsDisabledControlJustReleased(0, SPEED_RESET) then
--                 Speed = 1
--             end

--             local multi = 1.0
--             if IsControlAlwaysPressed(0, SPEED_FAST_MODIFIER) then
--                 multi = 2			
--             elseif IsControlAlwaysPressed(0, SPEED_FASTER_MODIFIER) then
--                 multi = 4			
--             elseif IsControlAlwaysPressed(0, SPEED_SLOW_MODIFIER) then
--                 multi = 0.25
--             end

--             if IsControlAlwaysPressed(0, MOVE_FORWARDS) then
--                 local pitch = GetCamRot(Camera, 0)

--                 if pitch.x >= 0 then
--                     SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.5*(Speed * multi), (pitch.x*((Speed/2) * multi))/89))
--                 else
--                     SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.5*(Speed * multi), -1*((math.abs(pitch.x)*((Speed/2) * multi))/89)))
--                 end
--             elseif IsControlAlwaysPressed(0, MOVE_BACKWARDS) then
--                 local pitch = GetCamRot(Camera, 2)

--                 if pitch.x >= 0 then
--                     SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, -0.5*(Speed * multi), -1*(pitch.x*((Speed/2) * multi))/89))
--                 else
--                     SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, -0.5*(Speed * multi), ((math.abs(pitch.x)*((Speed/2) * multi))/89)))
--                 end
--             end

--             if IsControlAlwaysPressed(0, MOVE_LEFT) then 			
--                 SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, -0.5*(Speed * multi), 0.0, 0.0))
--             elseif IsControlAlwaysPressed(0, MOVE_RIGHT) then
--                 SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.5*(Speed * multi), 0.0, 0.0))
--             end

--             if IsControlAlwaysPressed(0, MOVE_UP) then 			
--                 SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.0, 0.5*(Speed * multi)))
--             elseif IsControlAlwaysPressed(0, MOVE_DOWN) then
--                 SetEntityCoordsNoOffset(NoClipEntity, GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, 0.0, -0.5*(Speed * multi)))
--             end

--             local coords = GetEntityCoords(NoClipEntity)
   
--             RequestCollisionAtCoord(coords.x, coords.y, coords.z)

--             FreezeEntityPosition(NoClipEntity, true)
--             SetEntityCollision(NoClipEntity, false, false)
--             SetEntityVisible(NoClipEntity, false, false)
--             SetEntityInvincible(NoClipEntity, true)
--             SetLocalPlayerVisibleLocally(true)
--             SetEntityAlpha(NoClipEntity, NoClipAlpha, false)
--             if PlayerIsInVehicle == 1 then
--                 SetEntityAlpha(PlayerPed, NoClipAlpha, false)
--             end
--             SetEveryoneIgnorePlayer(PlayerPed, true)
--             SetPoliceIgnorePlayer(PlayerPed, true)
--         end
--         StopNoClip()
--     end)
-- end

-- StopNoClip = function()
--     FreezeEntityPosition(NoClipEntity, false)
--     SetEntityCollision(NoClipEntity, true, true)
--     SetEntityVisible(NoClipEntity, true, false)
--     SetLocalPlayerVisibleLocally(true)
--     ResetEntityAlpha(NoClipEntity)
--     ResetEntityAlpha(PlayerPed)
--     SetEveryoneIgnorePlayer(PlayerPed, false)
--     SetPoliceIgnorePlayer(PlayerPed, false)
--     ResetEntityAlpha(NoClipEntity)
--     SetPoliceIgnorePlayer(PlayerPed, true)

--     if GetVehiclePedIsIn(PlayerPed, false) ~= 0 then
--         while (not IsVehicleOnAllWheels(NoClipEntity)) and not IsNoClipping do
--             Wait(0)
--         end
--         while not IsNoClipping do
--             Wait(0)
--             if IsVehicleOnAllWheels(NoClipEntity) then
--                 return SetEntityInvincible(NoClipEntity, false)
--             end
--         end
--     else
--         if (IsPedFalling(NoClipEntity) and math.abs(1 - GetEntityHeightAboveGround(NoClipEntity)) > 1.00) then
--             while (IsPedStopped(NoClipEntity) or not IsPedFalling(NoClipEntity)) and not IsNoClipping do
--                 Wait(0)
--             end
--         end
--         while not IsNoClipping do
--             Wait(0)
--             if (not IsPedFalling(NoClipEntity)) and (not IsPedRagdoll(NoClipEntity)) then
--                 return SetEntityInvincible(NoClipEntity, false)
--             end
--         end
--     end
-- end

-- ToggleNoClip = function(state)
--     IsNoClipping = state or not IsNoClipping
--     PlayerPed    = PlayerPedId()
--     PlayerIsInVehicle = IsPedInAnyVehicle(PlayerPed, false)
--     if PlayerIsInVehicle ~= 0 and IsPedDrivingVehicle(PlayerPed, GetVehiclePedIsIn(PlayerPed, false)) then
--         NoClipEntity = GetVehiclePedIsIn(PlayerPed, false)
--         SetVehicleEngineOn(NoClipEntity, not IsNoClipping, true, IsNoClipping)
--         NoClipAlpha = PedFirstPersonNoClip == true and 0 or 51
--     else
--         NoClipEntity = PlayerPed
--         NoClipAlpha = VehFirstPersonNoClip == true and 0 or 51
--     end

--     if IsNoClipping then
--         FreezeEntityPosition(PlayerPed)
--         SetupCam()
--         PlaySoundFromEntity(-1, "SELECT", PlayerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)

--         if not PlayerIsInVehicle then
--             ClearPedTasksImmediately(PlayerPed)
--             if PedFirstPersonNoClip then
--                 Citizen.Wait(1000) -- Wait for the cinematic effect of the camera transitioning into first person 
--             end
--         else
--             if VehFirstPersonNoClip then
--                 Citizen.Wait(1000) -- Wait for the cinematic effect of the camera transitioning into first person 
--             end
--         end

--     else
--         local groundCoords      = GetGroundCoords(GetEntityCoords(NoClipEntity))
--         local entityHeading     = GetEntityHeading(NoClipEntity)
--         SetEntityCoords(NoClipEntity, groundCoords.x, groundCoords.y, groundCoords.z)
--         Citizen.Wait(50)
--         DestroyCamera(NoClipEntity)
--         PlaySoundFromEntity(-1, "CANCEL", PlayerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
--     end
    
--     QBCore.Functions.Notify(IsNoClipping and "No-clip enabled" or "No-clip disabled")
--     SetUserRadioControlEnabled(not IsNoClipping)
   
--     if IsNoClipping then
--         RunNoClipThread()
--     end
-- end

-- RegisterNetEvent('qb-admin:client:ToggleNoClip', function()
--     ToggleNoClip(not IsNoClipping)
-- end)

-- AddEventHandler('onResourceStop', function(resourceName)
--     if resourceName == ResourceName then
--         FreezeEntityPosition(NoClipEntity, false)
--         FreezeEntityPosition(PlayerPed, false)
--         SetEntityCollision(NoClipEntity, true, true)
--         SetEntityVisible(NoClipEntity, true, false)
--         SetLocalPlayerVisibleLocally(true)
--         ResetEntityAlpha(NoClipEntity)
--         ResetEntityAlpha(PlayerPed)
--         SetEveryoneIgnorePlayer(PlayerPed, false)
--         SetPoliceIgnorePlayer(PlayerPed, false)
--         ResetEntityAlpha(NoClipEntity)
--         SetPoliceIgnorePlayer(PlayerPed, true)
--         SetEntityInvincible(NoClipEntity, false)
--     end
-- end)


--[[
  * Created by MiiMii1205
  * license MIT
--]] -- Variables --
local MOVE_UP_KEY = 20
local MOVE_DOWN_KEY = 44
local CHANGE_SPEED_KEY = 21
local MOVE_LEFT_RIGHT = 30
local MOVE_UP_DOWN = 31
local NOCLIP_TOGGLE_KEY = 289
local NO_CLIP_NORMAL_SPEED = 0.5
local NO_CLIP_FAST_SPEED = 2.5
local ENABLE_NO_CLIP_SOUND = true
local eps = 0.01
local RESSOURCE_NAME = GetCurrentResourceName();
local isNoClipping = false
local speed = NO_CLIP_NORMAL_SPEED
local input = vector3(0, 0, 0)
local previousVelocity = vector3(0, 0, 0)
local breakSpeed = 10.0;
local offset = vector3(0, 0, 1);
local noClippingEntity = playerPed;

local function IsControlAlwaysPressed(inputGroup, control)
    return IsControlPressed(inputGroup, control) or IsDisabledControlPressed(inputGroup, control)
end

local function Lerp(a, b, t)
    return a + (b - a) * t
end

local function IsPedDrivingVehicle(ped, veh)
    return ped == GetPedInVehicleSeat(veh, -1);
end

local function SetInvincible(val, id)
    SetEntityInvincible(id, val)
    return SetPlayerInvincible(id, val)
end

local function MoveInNoClip()
    SetEntityRotation(noClippingEntity, GetGameplayCamRot(0), 0, false)
    local forward, right, up, c = GetEntityMatrix(noClippingEntity);
    previousVelocity = Lerp(previousVelocity,
        (((right * input.x * speed) + (up * -input.z * speed) + (forward * -input.y * speed))), Timestep() * breakSpeed);
    c = c + previousVelocity
    SetEntityCoords(noClippingEntity, c - offset, true, true, true, false)

end

local function SetNoClip(val)
    if (isNoClipping ~= val) then
        local playerPed = PlayerPedId()
        noClippingEntity = playerPed;
        if IsPedInAnyVehicle(playerPed, false) then
            local veh = GetVehiclePedIsIn(playerPed, false);
            if IsPedDrivingVehicle(playerPed, veh) then
                noClippingEntity = veh;
            end
        end
        local isVeh = IsEntityAVehicle(noClippingEntity);
        isNoClipping = val;
        if ENABLE_NO_CLIP_SOUND then
            if isNoClipping then
                PlaySoundFromEntity(-1, "SELECT", playerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
            else
                PlaySoundFromEntity(-1, "CANCEL", playerPed, "HUD_LIQUOR_STORE_SOUNDSET", 0, 0)
            end
        end
        TriggerEvent('msgprinter:addMessage',
            ((isNoClipping and ":airplane: No-clip enabled") or ":rock: No-clip disabled"), GetCurrentResourceName());
        SetUserRadioControlEnabled(not isNoClipping);
        if (isNoClipping) then
            TriggerEvent('instructor:add-instruction', {MOVE_LEFT_RIGHT, MOVE_UP_DOWN}, "move", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', {MOVE_UP_KEY, MOVE_DOWN_KEY}, "move up/down", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', {1, 2}, "Turn", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', CHANGE_SPEED_KEY, "(hold) fast mode", RESSOURCE_NAME);
            TriggerEvent('instructor:add-instruction', NOCLIP_TOGGLE_KEY, "Toggle No-clip", RESSOURCE_NAME);
            SetEntityAlpha(noClippingEntity, 51, 0)
            -- Start a No CLip thread
            CreateThread(function()
                local clipped = noClippingEntity
                local pPed = playerPed;
                local isClippedVeh = isVeh;
                -- We start with no-clip mode because of the above if --
                SetInvincible(true, clipped);
                if not isClippedVeh then
                    ClearPedTasksImmediately(pPed)
                end
                while isNoClipping do
                    Wait(0);
                    FreezeEntityPosition(clipped, true);
                    SetEntityCollision(clipped, false, false);
                    SetEntityVisible(clipped, false, false);
                    SetLocalPlayerVisibleLocally(true);
                    SetEntityAlpha(clipped, 51, false)
                    SetEveryoneIgnorePlayer(pPed, true);
                    SetPoliceIgnorePlayer(pPed, true);
                    input = vector3(GetControlNormal(0, MOVE_LEFT_RIGHT), GetControlNormal(0, MOVE_UP_DOWN), (IsControlAlwaysPressed(1, MOVE_UP_KEY) and 1) or ((IsControlAlwaysPressed(1, MOVE_DOWN_KEY) and -1) or 0))
                    speed = ((IsControlAlwaysPressed(1, CHANGE_SPEED_KEY) and NO_CLIP_FAST_SPEED) or NO_CLIP_NORMAL_SPEED) * ((isClippedVeh and 2.75) or 1)
                    MoveInNoClip();
                end
                Wait(0);
                FreezeEntityPosition(clipped, false);
                SetEntityCollision(clipped, true, true);
                SetEntityVisible(clipped, true, false);
                SetLocalPlayerVisibleLocally(true);
                ResetEntityAlpha(clipped);
                SetEveryoneIgnorePlayer(pPed, false);
                SetPoliceIgnorePlayer(pPed, false);
                ResetEntityAlpha(clipped);
                Wait(500);
                if isClippedVeh then
                    while (not IsVehicleOnAllWheels(clipped)) and not isNoClipping do
                        Wait(0);
                    end
                    while not isNoClipping do
                        Wait(0);
                        if IsVehicleOnAllWheels(clipped) then
                            return SetInvincible(false, clipped);
                        end
                    end
                else
                    if (IsPedFalling(clipped) and math.abs(1 - GetEntityHeightAboveGround(clipped)) > eps) then
                        while (IsPedStopped(clipped) or not IsPedFalling(clipped)) and not isNoClipping do
                            Wait(0);
                        end
                    end
                    while not isNoClipping do
                        Wait(0);
                        if (not IsPedFalling(clipped)) and (not IsPedRagdoll(clipped)) then
                            return SetInvincible(false, clipped);
                        end
                    end
                end
            end)
        else
            ResetEntityAlpha(noClippingEntity)
            TriggerEvent('instructor:flush', RESSOURCE_NAME);
        end
    end
end

function ToggleNoClipMode()
    return SetNoClip(not isNoClipping)
end

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == RESSOURCE_NAME then
        SetNoClip(false);
        FreezeEntityPosition(noClippingEntity, false);
        SetEntityCollision(noClippingEntity, true, true);
        SetEntityVisible(noClippingEntity, true, false);
        SetLocalPlayerVisibleLocally(true);
        ResetEntityAlpha(noClippingEntity);
        SetEveryoneIgnorePlayer(playerPed, false);
        SetPoliceIgnorePlayer(playerPed, false);
        ResetEntityAlpha(noClippingEntity);
        SetInvincible(false, noClippingEntity);
    end
end)

RegisterNetEvent('qb-admin:client:ToggleNoClip', function()
    ToggleNoClipMode()
end)