function CerconeAddon.ShowGrimorioPageOld(vista)
    if vista < 1 or vista > #GrimorioData then
        d("Página fuera de rango")
        return
    end

    CerconeAddon.currentVista = vista
    local data = GrimorioData[vista]

    -- Página izquierda
    GetControl("Grimorio_Titulo"):SetText(data.Titulo)
    GetControl("Grimorio_SubTitulo1"):SetText(data.SubTitulo1 or "")
    GetControl("Grimorio_Parrafo1"):SetText(data.Parrafo1 or "")
    GetControl("Grimorio_ParrafoCierre1"):SetText(data.ParrafoCierre1 or "")

    -- Página derecha
    GetControl("Grimorio_SubTitulo2"):SetText(data.SubTitulo2 or "")
    GetControl("Grimorio_Parrafo2"):SetText(data.Parrafo2 or "")
    GetControl("Grimorio_ParrafoCierre2"):SetText(data.ParrafoCierre2 or "")
    GetControl("Grimorio_SubTitulo3"):SetText(data.SubTitulo3 or "")
    GetControl("Grimorio_Parrafo3"):SetText(data.Parrafo3 or "")
    GetControl("Grimorio_ParrafoCierre3"):SetText(data.ParrafoCierre3 or "")

    -- Agregar parrafos adicionales si existen
    for i = 4, 9 do
        local subTituloKey = "SubTitulo" .. i
        local parrafoKey = "Parrafo" .. i
        local parrafoCierreKey = "ParrafoCierre" .. i
        
        local subTitulo = data[subTituloKey] or ""
        local parrafo = data[parrafoKey] or ""
        local parrafoCierre = data[parrafoCierreKey] or ""
        
        local subTituloControl = GetControl("Grimorio_SubTitulo" .. i)
        local parrafoControl = GetControl("Grimorio_Parrafo" .. i)
        local parrafoCierreControl = GetControl("Grimorio_ParrafoCierre" .. i)
        
        if subTituloControl then
            subTituloControl:SetText(subTitulo)
        end
        if parrafoControl then
            parrafoControl:SetText(parrafo)
        end
        if parrafoCierreControl then
            parrafoCierreControl:SetText(parrafoCierre)
        end
    end
    
    -- Actualizar textos de páginas
    GetControl("Grimorio_PageLeft"):SetText(tostring((vista - 1) * 2 + 1))
    GetControl("Grimorio_PageRight"):SetText(tostring(vista * 2))
    GetControl("Grimorio"):SetHidden(false)
end

-- Función para formatear la descripción en varias líneas
function CerconeAddon.FormatDescriptionMultiline(description)
    if not description then return "" end
    
    local colorCode = "800000"
    local parts = {}
    
    -- Dividir por líneas
    for line in description:gmatch("[^\n]+") do
        -- Procesar cada línea independientemente
        local formattedLine = line:gsub("([^%s][^:]-):", "|c"..colorCode.."%1:|r")
        table.insert(parts, formattedLine)
    end
    
    -- Unir las líneas procesadas
    return table.concat(parts, "\n"):gsub("\n", "\n ")
end

function CerconeAddon.ShowGrimorioPage(title)
    local data = CerconeGrimoireData
    local i = 1
    local currentSubTitle = ""

    -- Limpiar la data del grimorio
    GetControl("GrimorioTitulo"):SetText("")
    GetControl("GrimorioNombreRama1"):SetText("")
    GetControl("GrimorioNombreRama4"):SetText("")
    for j = 1, 6 do
        GetControl("GrimorioDescripcion"..j):SetText("")
        GetControl("GrimorioValores"..j):SetText("")
    end

    -- Página izquierda
    for _, item in pairs(data) do
        if item.Nombre == title then
            if i > 6 then break end
            local description = CerconeAddon.FormatDescriptionMultiline(item.Descripcion)
            local colonPos = description:find(":")
            
            if colonPos then
                local prefix = description:sub(1, colonPos - 1)
                local suffix = description:sub(colonPos + 1)
                description = "|c800000" .. prefix .. ":|r" .. suffix
            end

            if currentSubTitle ~= item.NombreRama and currentSubTitle ~= "" then 
                i = 3
            else
                d(i)
                GetControl("GrimorioTitulo"):SetText(item.Nombre)
                if i == 1 or i == 4 then 
                    GetControl("GrimorioNombreRama"..i):SetText(item.NombreRama or "")
                end
                GetControl("GrimorioDescripcion"..i):SetText(description or "")
                GetControl("GrimorioValores"..i):SetText(item.Valores or "")
            end
            i = i + 1
            currentSubTitle = item.NombreRama
        end
    end

    GetControl("Grimorio"):SetHidden(false)
end

function CerconeAddon.ShowGrimorio()
    local indexData = CerconeGrimoireData
    if not indexData or #indexData == 0 then
        d("No hay datos para mostrar en el índice")
        return
    end

    -- Índice
    local tituloControl = GetControl("Indice_Titulo")
    if tituloControl then
        tituloControl:SetText("Índice")
    end

    local usedTitle = ""
    local pagesPerTitle = 3
    for i, item in pairs(indexData) do
        if not item.Z then
            break
        end

        if usedTitle ~= item.Nombre then
            GetControl("Indice_Titulo"..item.Z):SetText(item.Nombre or "")
            GetControl("Indice_TPagina"..item.Z):SetText(pagesPerTitle+1 or "")
        end
        
        if item.Nombre == usedTitle then
            pagesPerTitle = pagesPerTitle + 1
        end
        
        usedTitle = item.Nombre
    end

    -- Agregar efectos de hover a los ítems del índice
    for i = 1, 100 do
        if not GetControl("Indice_Titulo"..i) then
            break
        end
        CerconeAddon.AddHoverEffect(GetControl("Indice_Titulo"..i):GetName(), "FFFFFF", "800000")
    end
end

function CerconeAddon.NavigateGrimorio(direction)
    local newVista = CerconeAddon.currentVista + direction
    if newVista < 1 or newVista > #GrimorioData then
        d("No hay más páginas en esa dirección")
        return
    end
    CerconeAddon.ShowGrimorioPage(newVista)
end

function CerconeAddon.AddHoverEffect(label, normalColor, hoverColor)
    local labelControl = GetControl(label)
    if not labelControl then
        d("|cFF0000Error:|r Control no encontrado: " ..label)
        return
    end

    -- Habilitamos el MouseEnabled para el control
    labelControl:SetMouseEnabled(true)

    -- Convertir los colores hexadecimales a formato ZO
    local function ParseColor(hexColor)
        hexColor = hexColor:gsub("#", "")
        local r, g, b = tonumber(hexColor:sub(1, 2), 16), tonumber(hexColor:sub(3, 4), 16), tonumber(hexColor:sub(5, 6), 16)
        return r, g, b
    end

    labelControl:SetHandler("OnMouseEnter", function()
        local r, g, b = ParseColor(hoverColor)
        labelControl:SetColor(r / 255, g / 255, b / 255, 1) -- Cambia el color al pasar el mouse
    end)

    labelControl:SetHandler("OnMouseExit", function()
        local r, g, b = ParseColor(normalColor)
        labelControl:SetColor(r / 255, g / 255, b / 255, 1) -- Vuelve al color normal al salir del mouse
    end)

    labelControl:SetHandler("OnMouseUp", function()
        CerconeAddon.ShowGrimorioPage(labelControl:GetText())
        GetControl("GrimorioIndice"):SetHidden(true)
    end)
end
