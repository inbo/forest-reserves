return {
  ['title'] = function(args, kwargs, meta)
--[[check if variable has content]]
    local function is_empty(s)
      return s == nil or s == ''
    end

--[[initialise]]
    if is_empty(meta.flandersqmd.cover) then
      z = ''
    else
      y = pandoc.utils.stringify(meta.flandersqmd.cover)
      y = y:match("(.+)%..*")
      z = '<img src="' .. y .. '.png">'
    end
    z = z .. '<div id="title-block-header" class="quarto-title-block default">'

--[[add title]]
    z = z .. '<div class="quarto-title">'
    if is_empty(meta.flandersqmd.title) then
      z = z .. '<h0 class = "missing">!!! Missing flandersqmd.title !!!</h0>'
    else
      z = z .. '<h0 class="title">' .. pandoc.utils.stringify(meta.flandersqmd.title) .. '</h0>'
    end

--[[add subtitle]]
    if not is_empty(meta.flandersqmd.subtitle) then
      z = z .. '<h1 class="subtitle">' .. pandoc.utils.stringify(meta.flandersqmd.subtitle) .. '</h1>'
    end
    z = z .. '</div>'

--[[finalise]]
    z = z .. '</div>'

    return pandoc.RawInline("html", z)
  end
}
