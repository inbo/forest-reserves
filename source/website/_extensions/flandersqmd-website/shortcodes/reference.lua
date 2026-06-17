return {
  ['reference'] = function(args, kwargs, meta)
--[[check if variable has content]]
    local function is_empty(s)
      return s == nil or s == ''
    end

--[[format person for bibtex]]
    local function bibtex_person(person, i, type)
      local res = ''
      if i > 1 then
        res = res .. ' and '
      end
      if is_empty(person.name) then
        res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type ..' element ' .. i .. ' has no name element!!!</h1>'
      else
        if is_empty(person.name.family) then
          res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type .. ' element ' .. i .. ' name element has no family element!!!</h1>'
        else
          res = res .. pandoc.utils.stringify(person.name.family) .. ', '
        end
        if is_empty(person.name.given) then
          res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type .. ' element ' .. i .. ' name element has no given element!!!</h1>'
        else
          res = res .. pandoc.utils.stringify(person.name.given)
        end
      end
      return res
    end

--[[format person for ris]]
    local function ris_person(person, i, type)
      local res = 'AU  - '
      if is_empty(person.name) then
        res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type ..' element ' .. i .. ' has no name element!!!</h1>'
      else
        if is_empty(person.name.family) then
          res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type .. ' element ' .. i .. ' name element has no family element!!!</h1>'
        else
          res = res .. pandoc.utils.stringify(person.name.family) .. ', '
        end
        if is_empty(person.name.given) then
          res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type .. ' element ' .. i .. ' name element has no given element!!!</h1>'
        else
          res = res .. pandoc.utils.stringify(person.name.given) .. '\n'
        end
      end
      return res
    end

--[[format person for json]]
    local function json_person(person, i, type)
      local res = '    {\n'
      if not is_empty(person.name) then
        if not is_empty(person.name.family) then
          res = res .. '      "family":"' .. pandoc.utils.stringify(person.name.family) .. '",\n'
        end
        if not is_empty(person.name.given) then
          res = res .. '      "given":"' .. pandoc.utils.stringify(person.name.given) .. '"\n    },\n'
        end
      end
      return res
    end

--[[initialise]]
    z = ''

--[[add authors]]
    z = z .. '<div>'

--[[add reviewer]]
    if tonumber(pandoc.utils.stringify(meta.displaycolophon)) > 0 then

  --[ insert year]
    if not is_empty(meta.flandersqmd.year) then
      z = z .. '<div>' .. '<div class="quarto-title-meta-heading">' ..
        meta.translation.year .. '</div>' ..
        '<div class="quarto-title-meta-contents">' .. '<p class="date">' ..
        pandoc.utils.stringify(meta.flandersqmd.year) .. '</div>' .. '</div>'
    end

  --[[end meta]]
      z = z .. '</div>'

  --[ insert citation]
    z = z .. '<div class="quarto-title-meta-heading">' ..
      meta.translation.citation .. '</div>' ..
      '<div class="quarto-title-meta-contents">'
      if is_empty(meta.flandersqmd.author) then
        z = z .. '<h1 class = "missing">!!! Missing flandersqmd.author !!!</h1>'
      else
        z = z .. meta.shortauthor
      end
    if is_empty(meta.flandersqmd.year) then
      z = z .. '<h1 class = "missing">!!! Missing flandersqmd.year !!!</h1>'
    else
      z = z .. ' (' .. pandoc.utils.stringify(meta.flandersqmd.year) .. ') '
    end
    if is_empty(meta.flandersqmd.title) then
      z = z .. '<h1 class = "missing">!!! Missing flandersqmd.title !!!</h1>'
    else
      z = z .. pandoc.utils.stringify(meta.flandersqmd.title) .. '. '
      if not is_empty(meta.flandersqmd.subtitle) then
        z = z .. pandoc.utils.stringify(meta.flandersqmd.subtitle) .. '. '
      end
    end
    if not is_empty(meta.translation.name) then
      z = z .. meta.translation.name .. ' '
    end
    if is_empty(meta.flandersqmd.url) then
      z = z .. '<h1 class = "missing">!!! Missing flandersqmd.url !!!</h1>'
    else
      z = z .. pandoc.utils.stringify(meta.flandersqmd.url)
    end
    z = z .. '</div>'

    z = z .. '<div>' .. meta.translation.export ..
      '<button onclick="display_export(\'bibtexf\')" class="colophon-button">BibTex</button>' ..
      '<button onclick="display_export(\'RISf\')" class="colophon-button">RIS</button>' ..
      '<button onclick="display_export(\'cslf\')" class="colophon-button">CSL-JSON</button>' ..
      '<script>' .. 'function display_export(id) {' ..
      'var x = document.getElementById(id);' ..
      'if (x.style.display === "none") {' .. 'x.style.display = "block";' ..
      '} else {' .. 'x.style.display = "none";' .. '}' .. '}' .. '</script>'
    z = z .. '<pre id = "bibtexf" style ="display: none;">\n' .. '@online{\n'
      if is_empty(meta.flandersqmd.author) then
        z = z .. '<h1 class = "missing">!!! Missing flandersqmd.author !!!</h1>'
      else
        z = z .. '  author = {'
        for i, person in pairs(meta.flandersqmd.author) do
          z = z .. bibtex_person(person, i, 'author')
        end
        z = z .. '},\n'
      end
      if not is_empty(meta.flandersqmd.title) then
        z = z .. '  title = {' .. pandoc.utils.stringify(meta.flandersqmd.title) .. '.'
        if not is_empty(meta.flandersqmd.subtitle) then
          z = z .. '  ' .. pandoc.utils.stringify(meta.flandersqmd.subtitle) .. '.'
        end
        z = z .. '},\n'
      end
      if not is_empty(meta.translation.name) then
        z = z .. '  institution = {' .. meta.translation.name .. '},\n'
      end
      if not is_empty(meta.translation.address) then
        z = z .. '  address = {' .. meta.translation.city .. '},\n'
      end
      if is_empty(meta.flandersqmd.year) then
        z = z .. '<h1 class = "missing">!!! Missing flandersqmd.year !!!</h1>'
      else
        y = pandoc.utils.stringify(meta.flandersqmd.year)
        z = z .. '  year = {' .. y .. '},\n'
      end
      if tonumber(pandoc.utils.stringify(meta.public)) > 0 then
        if is_empty(meta.flandersqmd.doi) then
          z = z .. '<h1 class = "missing">!!! Missing flandersqmd.doi !!!</h1>'
        else
          local x = pandoc.utils.stringify(meta.flandersqmd.doi)
          z = z .. '  doi = {' .. x .. '},\n'
        end
      end
      if is_empty(meta.flandersqmd.url) then
        z = z .. '<h1 class = "missing">!!! Missing flandersqmd.url !!!</h1>'
      else
        z = z .. '  url = {' .. pandoc.utils.stringify(meta.flandersqmd.url) ..  '}\n'
      end
      z = z  .. '}' .. '</pre>\n'
      z = z .. '<pre id = "RISf" style ="display: none;">\n' .. 'TY  - WEB\n'
      if is_empty(meta.flandersqmd.author) then
        z = z .. '<h1 class = "missing">!!! Missing flandersqmd.author !!!</h1>'
      else
        for i, person in pairs(meta.flandersqmd.author) do
          z = z .. ris_person(person, i, 'author')
        end
      end
      if not is_empty(meta.flandersqmd.title) then
        z = z .. 'TI  - ' .. pandoc.utils.stringify(meta.flandersqmd.title) .. '.'
        if not is_empty(meta.flandersqmd.subtitle) then
          z = z .. '  ' .. pandoc.utils.stringify(meta.flandersqmd.subtitle) .. '.'
        end
        z = z .. '\n'
      end
      if tonumber(pandoc.utils.stringify(meta.public)) > 0 and not is_empty(meta.flandersqmd.doi) then
        local x = pandoc.utils.stringify(meta.flandersqmd.doi)
        z = z .. 'DO  - ' .. x .. '\n'
      end
      if not is_empty(meta.translation.name) then
        z = z .. 'PB  - ' .. meta.translation.name .. '\n'
      end
      if not is_empty(meta.translation.address) then
        z = z .. 'CY  - ' .. meta.translation.city .. '\n'
      end
      if not is_empty(meta.flandersqmd.year) then
        local x = pandoc.utils.stringify(meta.flandersqmd.year)
        z = z .. 'PY  - ' .. x .. '\n'
      end
      if not is_empty(meta.flandersqmd.url) then
        z = z .. 'UR - ' .. pandoc.utils.stringify(meta.flandersqmd.url) ..  '\n'
      end
      if tonumber(pandoc.utils.stringify(meta.public)) > 0 and not is_empty(meta.translation.issn) then
        z = z .. 'SN  - ' .. meta.translation.issn .. '\n'
      end
      z = z .. 'ER  -\n' .. '</pre>'

      z = z .. '<pre id = "cslf" style ="display: none;">\n' .. '{\n' ..
        '  "type":"webpage",\n'
      if not is_empty(meta.flandersqmd.title) then
        z = z .. '  "title":"' .. pandoc.utils.stringify(meta.flandersqmd.title) .. '.'
        if not is_empty(meta.flandersqmd.subtitle) then
          z = z .. '  ' .. pandoc.utils.stringify(meta.flandersqmd.subtitle) .. '.'
        end
        z = z .. '",\n'
      end
      if not is_empty(meta.flandersqmd.author) then
        z = z .. '  "author":[\n'
        for i, person in pairs(meta.flandersqmd.author) do
          z = z .. json_person(person, i, 'author')
        end
        z = z:sub(1, -3) .. '\n  ],\n'
      end
      if tonumber(pandoc.utils.stringify(meta.public)) > 0 and not is_empty(meta.flandersqmd.doi) then
        local x = pandoc.utils.stringify(meta.flandersqmd.doi)
        z = z .. '  "DOI":"' .. x .. '",\n'
      end
      if not is_empty(meta.flandersqmd.url) then
        z = z .. '"URL":"' .. pandoc.utils.stringify(meta.flandersqmd.url) ..  '",\n'
      end
      if not is_empty(meta.flandersqmd.year) then
        y = pandoc.utils.stringify(meta.flandersqmd.year)
        z = z .. '  "issued":{"date-parts":[[' .. y .. ']]},\n'
      end
      if not is_empty(meta.translation.name) then
        z = z .. '  "publisher": "' .. meta.translation.name .. '",\n'
      end
      if not is_empty(meta.translation.address) then
        z = z .. '  "publisher-place":"' .. meta.translation.city .. '"\n'
      end
      z = z .. '}\n' .. '</pre>'
    end

--[[finalise]]
    z = z .. '</div>'

    return pandoc.RawInline("html", z)
  end
}
