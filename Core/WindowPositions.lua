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
    CerconeAddon.vars.windows[control:GetName()] = {
        left = control:GetLeft(),
        top = control:GetTop(),
    }
end

local function RestoreWindowPosition(control)
    local pos = CerconeAddon.vars.windows[control:GetName()]
    if not pos then return end

    local margin = 50
    local maxLeft = GuiRoot:GetWidth() - margin
    local maxTop = GuiRoot:GetHeight() - margin
    if pos.left < 0 or pos.top < 0 or pos.left > maxLeft or pos.top > maxTop then
        CerconeAddon.vars.windows[control:GetName()] = nil
        return
    end

    control:ClearAnchors()
    control:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, pos.left, pos.top)
end

function CerconeAddon.InitWindowPositions()
    CerconeAddon.vars = ZO_SavedVars:NewAccountWide("CerconeAddonVars", 1, nil, defaults)

    for _, name in ipairs(WINDOWS) do
        local control = WINDOW_MANAGER:GetControlByName(name)
        if control then
            RestoreWindowPosition(control)
            control:SetHandler("OnMoveStop", SaveWindowPosition)
        end
    end
end
