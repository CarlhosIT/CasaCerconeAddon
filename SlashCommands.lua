SLASH_COMMANDS["/pjinfo"] = function(name)
    CerconeAddon.ShowSimpleData(name)
  end
  
  SLASH_COMMANDS["/cerrarpj"] = function(extra)
    CerconeAddon.ClosePjUI()
  end
  
  SLASH_COMMANDS["/selectpj"] = function(namePj)
    CerconeAddon.SelectPjForDuel(namePj)
  end
  
  SLASH_COMMANDS["/sethp"] = function(hpValue)
    -- Convierte el valor de HP a un número
    local newHP = tonumber(hpValue)  
    -- Verifica si el valor es válido
    if newHP then
        -- Asigna el nuevo valor de HP al campo
        PjHPDuel:SetText("HP: "..newHP)
        d("Se ha asignado un nuevo valor de HP: " .. newHP)
    else
        d("El valor proporcionado no es válido.")
    end
  end
  
  SLASH_COMMANDS["/setdef"] = function(defValue)
    -- Convierte el valor de HP a un número
    local newHP = tonumber(defValue)  
    -- Verifica si el valor es válido
    if newHP then
        -- Asigna el nuevo valor de HP al campo
        PjDefDuel:SetText("Def: "..defValue)
        d("Se ha asignado un nuevo valor de Defensa: " .. newHP)
    else
        d("El valor proporcionado no es válido.")
    end
  end
  
  SLASH_COMMANDS["/setmagic"] = function(magickValue)
    -- Convierte el valor de HP a un número
    local newHP = tonumber(magickValue)  
    -- Verifica si el valor es válido
    if newHP then
        -- Asigna el nuevo valor de HP al campo
        PjMagickaDuel:SetText("Mag: "..magickValue)
        d("Se ha asignado un nuevo valor de Magica: " .. newHP)
    else
        d("El valor proporcionado no es válido.")
    end
  end
  