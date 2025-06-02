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

CerconeAddon.currentPage = 0

function CerconeAddon.ShowMissionBoard(page)
  CerconeAddon.currentPage = page or 1
  local boardData = CerconeTablonMisiones
  if not page then page = 1 end
  if not boardData or #boardData == 0 then
    chat:Print("No hay misiones.")
    return
  end

  local totalPages = 0

  for i, mission in pairs(boardData) do

    if mission.Texto ~= "" then
      totalPages = mission.Pagina > totalPages and mission.Pagina or totalPages
    end
    if mission.Pagina > page then break end

    local scroll = GetControl("Pergamino" .. mission.Slot)
    local title = GetControl("T" .. mission.Slot)
    local text = GetControl("Texto" .. mission.Slot)
    local requirements = GetControl("Req" .. mission.Slot)

    scroll:SetHidden(true)
    title:SetText("")
    text:SetText("")
    requirements:SetText("")

    if mission.Pagina == page and mission.Texto ~= "" then
      scroll:SetTexture(Estilos[mission.Estilo])
      title:SetText(mission.Titulo)
      text:SetText(mission.Texto)
      requirements:SetText("  Requisitos:\n" .. mission.Requisitos)

      scroll:SetHidden(false)
    end
  end

  local nextButton = GetControl("FlechaDER")
  local prevButton = GetControl("FlechaIZQ")

  if totalPages > page then
    nextButton:SetHidden(false)
  elseif totalPages == page then
    nextButton:SetHidden(true)
  end

  if page > 1 then
    prevButton:SetHidden(false)
  else
    prevButton:SetHidden(true)
  end
end

function CerconeAddon.ChangePage(value)
  local page = CerconeAddon.currentPage + value
  CerconeAddon.ShowMissionBoard(page)
end