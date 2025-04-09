-- Main.lua
CerconeAddon = {}
CerconeAddon.name = "CerconeAddon"
CerconeAddon.haveDuelUI = false

-- Cargar funciones de otros archivos
--dofile("UIFunctions.lua")
--dofile("SlashCommands.lua")

-- Método de arranque
function CerconeAddon.OnAddOnLoaded(eventCode, addOnName)
  if(addOnName ~= CerconeAddon.name) then return end
  CerconeAddon.ClosePjUI()
  CerconeAddon.haveDuelUI = false
  CerconeAddon.InitializeKeybindings()
  CerconeAddon.ShowGrimorioPage(1)
end

function CerconeAddon.NB1KeyBindToggle()
    local panel = WINDOW_MANAGER:GetControlByName("CerconePjDuel")
    if panel then
        local isHidden = panel:IsHidden()
        panel:SetHidden(not isHidden)
        if isHidden then
            CerconeAddon.OnCombatMenuOpen()
        else
            CerconeAddon.OnCombatMenuClose()
        end
        d(isHidden and "Mostrando menú de duelo" or "Ocultando menú de duelo")
    else
        d("No se encontró el control 'CerconePjDuel'")
    end
end

function CerconeAddon.ArbriGrimorio()
    local panel = WINDOW_MANAGER:GetControlByName("Grimorio")
    if panel then
        local isHidden = panel:IsHidden()
        panel:SetHidden(not isHidden)
        d(isHidden and "Mostrando grimorio" or "Ocultando grimorio")
    else
        d("No se encontró el control 'Grimorio'")
    end
end
function CerconeAddon.ArbriTablon()
    local panel = WINDOW_MANAGER:GetControlByName("Tablon")
    if panel then
        local isHidden = panel:IsHidden()
        panel:SetHidden(not isHidden)
        d(isHidden and "Mostrando Tablon de misiones" or "Ocultando Tablon de misiones")
    else
        d("No se encontró el control 'Tablon'")
    end
end

function CerconeAddon.InitializeKeybindings()
    ZO_CreateStringId("SI_BINDING_NAME_CERCONEADDON_NB1TOGGLE", "Cercone Combate")
    ZO_CreateStringId("SI_BINDING_NAME_CERCONEADDON_GRIMORIO", "Cercone Grimorio")
    ZO_CreateStringId("SI_BINDING_NAME_CERCONEADDON_TABLON", "Cercone Tablon")
end
-- Registro del addon
EVENT_MANAGER:RegisterForEvent(CerconeAddon.name, EVENT_ADD_ON_LOADED, CerconeAddon.OnAddOnLoaded)


