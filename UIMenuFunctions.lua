-- UIFunctions.lua

-- Función para cerrar panel de pjInfo
function CerconeAddon.HideMarkTextures()
    local textureNames = {
      "MarkClass1", "MarkClass2", "MarkClass3", "MarkClass4", "MarkClass5", "MarkClass6", "MarkClass7", "MarkClass8", "MarkClass9",
      "MarkWar1", "MarkWar2", "MarkWar3", "MarkWar4", "MarkWar5", "MarkWar6",
      "MarkProf1", "MarkProf2", "MarkProf3",
      "MarkLCf1", "MarkLCf2", "MarkLCf3"
    }
    for _, textureName in ipairs(textureNames) do
      local texture = WINDOW_MANAGER:GetControlByName(textureName)
      if texture then
        texture:SetHidden(true)
      end
    end
  end
  
  function CerconeAddon.ClosePjUI()
    local panel = WINDOW_MANAGER:GetControlByName("CerconePjSimpleUI")
    if panel then
      CerconeAddon.HideMarkTextures()
      panel:SetHidden(true)
    else
      d("No se encontró el control 'CerconePjSimpleUI'")
    end
  end
  
  function CerconeAddon.MarkClassSkillsFromValue(classSkills)
    local numOfSkills = tonumber(classSkills)
    
    for i = 1, 9 do
      local mark = WINDOW_MANAGER:GetControlByName("MarkClass" .. i)
      local emptyMark = WINDOW_MANAGER:GetControlByName("MarkClassEmpty" .. i)
      if mark then
        mark:SetHidden(i > numOfSkills)
        emptyMark:SetHidden(i <= numOfSkills)
      end
    end
  end
  
  function CerconeAddon.MarkWarSkillsFromValue(classSkills)
    local numOfSkills = tonumber(classSkills)
    for i = 1, 6 do
      local mark = WINDOW_MANAGER:GetControlByName("MarkWar" .. i)
      local emptyMark = WINDOW_MANAGER:GetControlByName("MarkWarEmpty" .. i)

      if mark then
        mark:SetHidden(i > numOfSkills)
        emptyMark:SetHidden(i <= numOfSkills)
      end
    end
  end
  
  function CerconeAddon.MarkProfSkillsFromValue(classSkills)
    local numOfSkills = tonumber(classSkills)
    for i = 1, 3 do
      local mark = WINDOW_MANAGER:GetControlByName("MarkProf" .. i)
      local emptyMark = WINDOW_MANAGER:GetControlByName("MarkProfEmpty" .. i)

      if mark then
        mark:SetHidden(i > numOfSkills)
        emptyMark:SetHidden(i <= numOfSkills)
      end
    end
  end
  
  function CerconeAddon.MarkLCSkillsFromValue(classSkills)
    local numOfSkills = tonumber(classSkills)
    for i = 1, 3 do
      local mark = WINDOW_MANAGER:GetControlByName("MarkLCf" .. i)
      local emptyMark = WINDOW_MANAGER:GetControlByName("MarkLCfEmpty" .. i)
      
      if mark then
        mark:SetHidden(i > numOfSkills)
        emptyMark:SetHidden(i <= numOfSkills)
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
    d("No se encontraron coincidencias para el término de búsqueda: " .. namePj)
  end
  
  function CerconeAddon.ShowSimpleData(name)
    local numPj = CerconeAddon.SearchpjByName(name)
    local index = tonumber(numPj)
    CerconeAddon.HideMarkTextures()
    if index and index >= 1 and index <= #CerconePjData then
      local pj = CerconePjData[index]
      d("Abriendo menu simple de: " .. pj.Personaje)
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
        CerconeAddon.MarkClassSkillsFromValue(pj.HabilidadesCombatientes.LeccionesClase)
        CerconeAddon.MarkWarSkillsFromValue(pj.HabilidadesCombatientes.ArteDeGuerra)
        CerconeAddon.MarkProfSkillsFromValue(pj.ProfLevel)
        CerconeAddon.MarkLCSkillsFromValue(pj.HabilidadesCombatientes.LinajeCercone)
        panel:SetHidden(false)
      else
        d("No se encontró el control 'CerconePjSimpleUI'")
      end
    else
      d("Sin resultados")
    end
  end
