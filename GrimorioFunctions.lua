function CerconeAddon.ShowGrimorioPage(vista)
    if vista < 1 or vista > #GrimorioData then
        d("Página fuera de rango")
        return
    end

    CerconeAddon.currentVista = vista
    local data = GrimorioData[vista]

    -- Índice
    GetControl("Indice_Titulo1"):SetText(data.Indice1 or "")
    GetControl("Indice_Titulo2"):SetText(data.Indice2 or "")
    GetControl("Indice_Titulo3"):SetText(data.Indice3 or "")
    GetControl("Indice_Titulo4"):SetText(data.Indice4 or "")
    GetControl("Indice_Titulo5"):SetText(data.Indice5 or "")
    GetControl("Indice_Titulo6"):SetText(data.Indice6 or "")
    GetControl("Indice_Titulo7"):SetText(data.Indice7 or "")
    GetControl("Indice_Titulo8"):SetText(data.Indice8 or "")
    GetControl("Indice_Titulo9"):SetText(data.Indice9 or "")
    GetControl("Indice_Titulo10"):SetText(data.Indice10 or "")
    GetControl("Indice_Titulo11"):SetText(data.Indice11 or "")
    GetControl("Indice_Titulo12"):SetText(data.Indice12 or "")
    GetControl("Indice_Titulo13"):SetText(data.Indice13 or "")
    GetControl("Indice_Titulo14"):SetText(data.Indice14 or "")
    GetControl("Indice_Titulo15"):SetText(data.Indice15 or "")
    GetControl("Indice_TPagina1"):SetText(data.Pagina1 or "")
    GetControl("Indice_TPagina2"):SetText(data.Pagina2 or "")
    GetControl("Indice_TPagina3"):SetText(data.Pagina3 or "")
    GetControl("Indice_TPagina4"):SetText(data.Pagina4 or "")
    GetControl("Indice_TPagina5"):SetText(data.Pagina5 or "")
    GetControl("Indice_TPagina6"):SetText(data.Pagina6 or "")
    GetControl("Indice_TPagina7"):SetText(data.Pagina7 or "")
    GetControl("Indice_TPagina8"):SetText(data.Pagina8 or "")
    GetControl("Indice_TPagina9"):SetText(data.Pagina9 or "")
    GetControl("Indice_TPagina10"):SetText(data.Pagina10 or "")
    GetControl("Indice_TPagina11"):SetText(data.Pagina11 or "")
    GetControl("Indice_TPagina12"):SetText(data.Pagina12 or "")
    GetControl("Indice_TPagina13"):SetText(data.Pagina13 or "")
    GetControl("Indice_TPagina14"):SetText(data.Pagina14 or "")
    GetControl("Indice_TPagina15"):SetText(data.Pagina15 or "")

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