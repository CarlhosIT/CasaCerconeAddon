-- Main.lua
ValkAddon = {}
ValkAddon.name = "CerconeAddon"
ValkAddon.haveDuelUI = false
-- Cargar funciones de otros archivos
--dofile("UIFunctions.lua")
--dofile("SlashCommands.lua")

-- Se carga la biblioteca de mensajes de chat
local LibChatMessage = LibChatMessage

-- Crear una instancia de ChatProxy con etiquetas
local chat = LibChatMessage("|cFF0020Valk Addon|r", "|cFF0020CA|r")  

-- Método de arranque
function ValkAddon.OnAddOnLoaded(eventCode, addOnName)
  if(addOnName ~= ValkAddon.name) then return end
  EVENT_MANAGER:UnregisterForEvent(ValkAddon.name, EVENT_ADD_ON_LOADED)
  ValkAddon.InitWindowPositions()
  ValkAddon.ClosePjUI()
  ValkAddon.haveDuelUI = false
  ValkAddon.InitializeKeybindings()
  ValkAddon.ShowGrimorio()
  ValkAddon.ShowMissionBoard()
end

function ValkAddon.NB1KeyBindToggle()
    local panel = WINDOW_MANAGER:GetControlByName("CerconePjDuel")
    if panel then
        local isHidden = panel:IsHidden()
        panel:SetHidden(not isHidden)
        if isHidden then
            ValkAddon.OnCombatMenuOpen()
        else
            ValkAddon.OnCombatMenuClose()
        end
    else
        chat:Print("No se encontró el control 'CerconePjDuel'")
    end
end

function ValkAddon.ArbriGrimorio()
    local panel = WINDOW_MANAGER:GetControlByName("GrimorioIndice")
    local panel2 = WINDOW_MANAGER:GetControlByName("Grimorio")
    if panel then
        panel:SetHidden(not panel:IsHidden())  
        if not panel2:IsHidden() then
            panel:SetHidden(true)
        end
        panel2:SetHidden(true)
        
        if not panel:IsHidden() then PlaySound("BOOK_OPEN") else PlaySound("BOOK_CLOSE") end
    else
        chat:Print("No se encontró el control 'GrimorioIndice'")
    end

    SetGameCameraUIMode(not panel:IsHidden())
end

function ValkAddon.ArbriTablon()
    local panel = WINDOW_MANAGER:GetControlByName("Tablon")
    if panel then
        local isHidden = panel:IsHidden()
        panel:SetHidden(not isHidden)
        ValkAddon.ShowMissionBoard()
    else
        chat:Print("No se encontró el control 'Tablon'")
    end

    SetGameCameraUIMode(not panel:IsHidden())
end

function ValkAddon.InitializeKeybindings()
    ZO_CreateStringId("SI_BINDING_NAME_CERCONEADDON_NB1TOGGLE", "Valk Addon Combate")
    ZO_CreateStringId("SI_BINDING_NAME_CERCONEADDON_GRIMORIO", "Valk Addon Grimorio")
    ZO_CreateStringId("SI_BINDING_NAME_CERCONEADDON_TABLON", "Valk Addon Tablon")
    ZO_CreateStringId("SI_BINDING_NAME_CERCONEADDON_PJINFO", "Valk Addon Pergamino")
end
-- Registro del addon
EVENT_MANAGER:RegisterForEvent(ValkAddon.name, EVENT_ADD_ON_LOADED, ValkAddon.OnAddOnLoaded)