-- UIFunctions.lua
local LibChatMessage = LibChatMessage
local chat = LibChatMessage("|cFF0020CerconeAddon|r", "|cFF0020CA|r")  

Siglas = {
  ["X"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaX.dds",
  ["AG"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaAG.dds",
  ["AL"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaAL.dds",
  ["AR"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaAR.dds",
  ["DK"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaDK.dds",
  ["HE"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaHE.dds",
  ["IC"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaIC.dds",
  ["LC"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaLC.dds",
  ["LI"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaLI.dds",
  ["NB"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaNB.dds",
  ["NE"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaNE.dds",
  ["SA"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaSA.dds",
  ["SO"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaSO.dds",
  ["TE"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaTE.dds",
  ["WA"] = "CerconeAddon/Assets/Scroll/Academy/AcademiaWA.dds",
  ["SAN"] = "CerconeAddon/Assets/Scroll/Academy/Sanguinaris.dds",
  ["CUS"] = "CerconeAddon/Assets/Scroll/Academy/Custode.dds",
  ["INQ"] = "CerconeAddon/Assets/Scroll/Academy/Inquisidores.dds",
  ["FRU"] = "CerconeAddon/Assets/Scroll/Academy/Frumentari.dds",
}

function CerconeAddon.AcademyInfo()
    local textureNames = {
      "MarkClass1", "MarkClass2", "MarkClass3", "MarkClass4", "MarkClass5", "MarkClass6", "MarkClass7", "MarkClass8", "MarkClass9",
      "MarkWar1", "MarkWar2", "MarkWar3", "MarkWar4", "MarkWar5", "MarkWar6", "MarkWar7",
      "MarkProf1", "MarkProf2", "MarkProf3",
      "MarkL1", "MarkL2", "MarkL3"
    }

    for _, textureName in ipairs(textureNames) do
      local texture = WINDOW_MANAGER:GetControlByName(textureName)
      if texture then
        texture:SetTexture("CerconeAddon/Assets/Scroll/Academy/AcademiaVacio.dds")
      end
    end
  end
  
  function CerconeAddon.ClosePjUI()
    local panel = WINDOW_MANAGER:GetControlByName("CerconePjSimpleUI")
    if panel then
      CerconeAddon.AcademyInfo()
      panel:SetHidden(true)
    else
      chat:Print("No se encontró el control 'CerconePjSimpleUI'")
    end
  end
  
  function SetAcademyTexture(classSkills, textureName)
    for i, item in ipairs(classSkills) do
      local mark = WINDOW_MANAGER:GetControlByName(textureName .. i)
      if item ~= "" then
          local ucItem = string.upper(item)
          mark:SetTexture(Siglas[ucItem])
      end
    end
  end
  
  function CerconeAddon.SearchpjByName(namePj)
    local searchTerm = string.lower(namePj)
    for index, pjInfo in ipairs(CerconePjData) do
      local pjName = string.lower(pjInfo.Personaje)
      if string.find(pjName, searchTerm, 1, true) then
        return index
      end
    end
    chat:Print("No se encontraron coincidencias para el término de búsqueda: " .. namePj)
  end
  
  function CerconeAddon.ShowSimpleData(name)
    local numPj = CerconeAddon.SearchpjByName(name)
    local index = tonumber(numPj)
    CerconeAddon.AcademyInfo()
    if index and index >= 1 and index <= #CerconePjData then
      local pj = CerconePjData[index]
      chat:Print("Abriendo menu simple de: " .. pj.Personaje)
      local panel = WINDOW_MANAGER:GetControlByName("CerconePjSimpleUI")
      if panel then
        PjName:SetText(pj.Personaje)
        PjRaza:SetText("Raza: " .. pj.DataGeneral.Raza)
        PjRango:SetText("Rango: " .. pj.DataGeneral.Rango)
        PjNacimiento:SetText("Nacimiento: " .. pj.DataGeneral.Nacimiento)
        PjOrden:SetText("Orden: " .. pj.DataGeneral.Orden)
        PjConvertido:SetText("Convertido: " .. pj.DataGeneral.FechaConvercion)
        PjArma:SetText("Arma: " .. pj.DataGeneral.Arma)
        PjSire:SetText("Sire: " .. pj.DataGeneral.Sire)
        PjMeritos:SetText("Total Meritos: " .. pj.Meritos.TotalMeritos)
        PjArmadura:SetText("Armadura: " .. pj.DataGeneral.Armadura)
        PjMisionesOrganizadas:SetText("Misiones Organizadas: " .. pj.Meritos.Misiones)
        PjHP:SetText("HP: " .. pj.HP)
        PjDef:SetText("Defensa: " .. pj.Defensa)
        PjMagicka:SetText("Magicka: " .. pj.Magicka)
        PjExploracion:SetText("Exploracion: +" .. pj.HabilidadesNOCombatientes.Exploracion)
        PjInvestigacion:SetText("Investigacion: +" .. pj.HabilidadesNOCombatientes.Investigacion)
        PjInutilizar:SetText("Inutilizar Mecanismo: +" .. pj.HabilidadesNOCombatientes.InutilizarM)
        PjSigilo:SetText("Sigilo: +" .. pj.HabilidadesNOCombatientes.Sigilo)
        PjPersuacion:SetText("Persuacion: +" .. pj.HabilidadesNOCombatientes.Persuacion)
        PjIntimidacion:SetText("Intimidacion: +" .. pj.HabilidadesNOCombatientes.Intimidacion)
        PjVoluntad:SetText("Voluntad : +" .. pj.HabilidadesNOCombatientes.Voluntad)
        PjPercepcion:SetText("Percepcion : +" .. pj.HabilidadesNOCombatientes.Percepcion)
        PjFuerza:SetText("Fuerza : +" .. pj.HabilidadesNOCombatientes.Fuerza)
        PjClaseAc:SetText(pj.DataGeneral.Clase .. ":")
        PjProfesion:SetText(pj.DataGeneral.Profesion .. ":")
        SetAcademyTexture(pj.HabilidadesCombatientes.LeccionesClase, "MarkClass")
        SetAcademyTexture(pj.HabilidadesCombatientes.ArteDeGuerra, "MarkWar")
        SetAcademyTexture(pj.ProfLevel, "MarkProf")
        SetAcademyTexture(pj.HabilidadesCombatientes.LinajeCercone, "MarkL")
        panel:SetHidden(false)
      else
        chat:Print("No se encontró el control 'CerconePjSimpleUI'")
      end
    else
      chat:Print("Sin resultados")
    end
  end
