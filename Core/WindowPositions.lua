-- WindowPositions.lua
-- Recuerda donde dejó el usuario cada ventana entre sesiones.

-- Grimorio NO está aquí a propósito.
local WINDOWS = {
    "CerconePjDuel",
    "CerconePjSimpleUI",
    "GrimorioIndice",
    "Tablon",
    "Mision",
}

-- Estructura inicial de SavedVars.
local defaults = { windows = {} }

local function SaveWindowPosition(control)
    ValkAddon.vars.windows[control:GetName()] = {
        left = control:GetLeft(),
        top = control:GetTop(),
    }
end

local function RestoreWindowPosition(control)
    local pos = ValkAddon.vars.windows[control:GetName()]
    if not pos then return end

    local margin = 50
    local maxLeft = GuiRoot:GetWidth() - margin
    local maxTop = GuiRoot:GetHeight() - margin
    if pos.left < 0 or pos.top < 0 or pos.left > maxLeft or pos.top > maxTop then
        ValkAddon.vars.windows[control:GetName()] = nil
        return
    end

    control:ClearAnchors()
    control:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, pos.left, pos.top)
end

function ValkAddon.InitWindowPositions()
    ValkAddon.vars = ZO_SavedVars:NewAccountWide("ValkAddonVars", 1, nil, defaults)

    for _, name in ipairs(WINDOWS) do
        local control = WINDOW_MANAGER:GetControlByName(name)
        if control then
            RestoreWindowPosition(control)
            control:SetHandler("OnMoveStop", SaveWindowPosition)
        end
    end
end
