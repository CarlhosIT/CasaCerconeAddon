-- UIFunctions.lua
local LibChatMessage = LibChatMessage
local chat = LibChatMessage("|cFF0020CerconeAddon|r", "|cFF0020CA|r")  

Estilos = {
  ["Custodes"] = "CerconeAddon/Assets/MissionBoard/PergaminoCustodes.dds",
  ["Clan"] = "CerconeAddon/Assets/MissionBoard/PergaminodelClan.dds",
  ["Frumentarii"] = "CerconeAddon/Assets/MissionBoard/PergaminoFrumentarii.dds",
  ["Indomito"] = "CerconeAddon/Assets/MissionBoard/PergaminoIndomito.dds",
  ["Inquisidores"] = "CerconeAddon/Assets/MissionBoard/PergaminoInquisidores.dds",
  ["Sanguinaris"] = "CerconeAddon/Assets/MissionBoard/PergaminoSanguinaris.dds",
}


function CerconeAddon.ShowMissionBoard(page)
  local boardData = CerconeTablonMisiones
  if not page then page = 1 end
  if not boardData or #boardData == 0 then
    chat:Print("No hay misiones.")
    return
  end

  for i, mission in pairs(boardData) do
    if mission.Pagina == page and mission.Texto ~= "" then
      local scroll = GetControl("Pergamino" .. mission.Slot)
      local title = GetControl("T" .. mission.Slot)
      local text = GetControl("Texto" .. mission.Slot)
      local requirements = GetControl("Req" .. mission.Slot)

      scroll:SetTexture(Estilos[mission.Estilo])
      title:SetText(mission.Titulo)
      text:SetText(mission.Texto)
      requirements:SetText("  Requisitos:\n" .. mission.Requisitos)

      scroll:SetHidden(false)
    end
  end
end