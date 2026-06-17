return {
  ['client_cooperation'] = function(args, kwargs, meta)
--[[check if variable has content]]
    local function is_empty(s)
      return s == nil or s == ''
    end

--[[initialise]]
    z = ''

--[[add client]]
    if not is_empty(meta.flandersqmd.client) then
      z = z .. '<div>' .. '<div class="quarto-title-meta-heading">' ..
        meta.translation.client .. '</div>' ..
        '<div class="quarto-title-meta-contents">'
      --for i, client in pairs(meta.flandersqmd.client) do
      --  z = z .. pandoc.utils.stringify(client) .. '<br>'
      --end
      if not is_empty(meta.flandersqmd.clientlogo) then
        z = z .. '<img src="' ..
          pandoc.utils.stringify(meta.flandersqmd.clientlogo) .. '" class="client">'
      end
      z = z .. '</div>' .. '</div>'
    end
    if not is_empty(meta.flandersqmd.cooperation) then
      z = z .. '<div>' .. '<div class="quarto-title-meta-heading">' ..
        meta.translation.cooperation .. '</div>' ..
        '<div class="quarto-title-meta-contents">'
      --for i, cooperation in pairs(meta.flandersqmd.cooperation) do
      --  z = z .. pandoc.utils.stringify(cooperation) .. '<br>'
      --end
      if not is_empty(meta.flandersqmd.cooperationlogo) then
        z = z .. '<img src="' ..
          pandoc.utils.stringify(meta.flandersqmd.cooperationlogo) .. '" class="client">'
      end
      z = z .. '</div>' .. '</div>'
    end

--[[finalise]]
    z = z .. '</div>'

    return pandoc.RawInline("html", z)
  end
}
