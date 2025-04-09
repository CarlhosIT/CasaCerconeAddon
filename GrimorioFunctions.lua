function CerconeAddon.ShowGrimorioPage(vista)
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
end

function CerconeAddon.NavigateGrimorio(direction)
    local newVista = CerconeAddon.currentVista + direction
    if newVista < 1 or newVista > #GrimorioData then
        d("No hay más páginas en esa dirección")
        return
    end
    CerconeAddon.ShowGrimorioPage(newVista)
end