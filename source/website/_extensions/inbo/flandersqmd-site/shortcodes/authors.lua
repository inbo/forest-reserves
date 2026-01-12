return {
  ['authors'] = function(args, kwargs, meta)
--[[check if variable has content]]
    local function is_empty(s)
      return s == nil or s == ''
    end

--[[format person]]
    local function display_person(person, i, type)
      local res = ''
      if i > 1 then
        res = res .. '<br>'
      end
      if not is_empty(person.email) then
        res = res .. '<a href= "mailto:' .. pandoc.utils.stringify(person.email) .. '">'
      end
      if is_empty(person.name) then
        res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type ..' element ' .. i .. ' has no name element!!!</h1>'
      else
        if is_empty(person.name.given) then
          res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type .. ' element ' .. i .. ' name element has no given element!!!</h1>'
        else
          res = res .. pandoc.utils.stringify(person.name.given)
        end
        if is_empty(person.name.family) then
          res = res .. '<h1 class = "missing">!!! flandersqmd.' .. type .. ' element ' .. i .. ' name element has no family element!!!</h1>'
        else
          res = res .. ' ' .. pandoc.utils.stringify(person.name.family)
        end
        if not is_empty(person.email) then
          res = res .. '</a>'
        end
      end
      if not is_empty(person.orcid) then
        local x = pandoc.utils.stringify(person.orcid)
        res = res .. '<a href="https://orcid.org/' .. x .. '" class="quarto-title-' .. type .. '-orcid"> <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA2ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDo1N0NEMjA4MDI1MjA2ODExOTk0QzkzNTEzRjZEQTg1NyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDozM0NDOEJGNEZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDozM0NDOEJGM0ZGNTcxMUUxODdBOEVCODg2RjdCQ0QwOSIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ1M1IE1hY2ludG9zaCI+IDx4bXBNTTpEZXJpdmVkRnJvbSBzdFJlZjppbnN0YW5jZUlEPSJ4bXAuaWlkOkZDN0YxMTc0MDcyMDY4MTE5NUZFRDc5MUM2MUUwNEREIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOjU3Q0QyMDgwMjUyMDY4MTE5OTRDOTM1MTNGNkRBODU3Ii8+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiA8P3hwYWNrZXQgZW5kPSJyIj8+84NovQAAAR1JREFUeNpiZEADy85ZJgCpeCB2QJM6AMQLo4yOL0AWZETSqACk1gOxAQN+cAGIA4EGPQBxmJA0nwdpjjQ8xqArmczw5tMHXAaALDgP1QMxAGqzAAPxQACqh4ER6uf5MBlkm0X4EGayMfMw/Pr7Bd2gRBZogMFBrv01hisv5jLsv9nLAPIOMnjy8RDDyYctyAbFM2EJbRQw+aAWw/LzVgx7b+cwCHKqMhjJFCBLOzAR6+lXX84xnHjYyqAo5IUizkRCwIENQQckGSDGY4TVgAPEaraQr2a4/24bSuoExcJCfAEJihXkWDj3ZAKy9EJGaEo8T0QSxkjSwORsCAuDQCD+QILmD1A9kECEZgxDaEZhICIzGcIyEyOl2RkgwAAhkmC+eAm0TAAAAABJRU5ErkJggg=="></a>'
      end
      if not is_empty(person.affiliation) then
        for i, instititute in pairs(person.affiliation) do
          res = res .. ', ' .. pandoc.utils.stringify(instititute)
        end
      end
      return res
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
          res = res .. '      "given":"' .. pandoc.utils.stringify(person.name.given) .. '"\n    }\n'
        end
      end
      return res
    end

--[[initialise]]
    z = ''

--[[add authors]]
    z = z .. '<div class="quarto-title-meta">' .. '<div>' ..
    '<div class="quarto-title-meta-heading">' .. meta.translation.author ..
    '</div>' .. '<div class="quarto-title-meta-contents">'
    if is_empty(meta.flandersqmd.author) then
      z = z .. '<h1 class = "missing">!!! Missing flandersqmd.author !!!</h1>'
    else
      for i, person in pairs(meta.flandersqmd.author) do
        z = z .. display_person(person, i, 'author')
      end
    end
    z = z .. '</div>' .. '</div>'

--[[add reviewer]]
    if tonumber(pandoc.utils.stringify(meta.displaycolophon)) > 0 then
      if not is_empty(meta.flandersqmd.reviewer) then
        z = z .. '<div>' .. '<div class="quarto-title-meta-heading">' ..
          meta.translation.reviewer .. '</div>' ..
          '<div class="quarto-title-meta-contents">'
        for i, person in pairs(meta.flandersqmd.reviewer) do
          z = z .. display_person(person, i, 'reviewer')
        end
        z = z .. '</div>' .. '</div>'
      end

    end

--[[finalise]]
    z = z .. '</div>'

    return pandoc.RawInline("html", z)
  end
}
