local block_id = 0

function CodeBlock(code)
  if (
        code.classes:includes("{adm}") or
        code.classes:includes("adm") 
      ) then
    return AdmCodeBlock(code)
  end
end

function ParseBlock(block, engine)
  local attr = {}
  local param_lines = {}
  local code_lines = {}
  for line in block.text:gmatch("([^\r\n]*)[\r\n]?") do
    local param_line = string.find(line, "^#|")
    if (param_line ~= nil) then
      table.insert(param_lines, string.sub(line, 4))
    else
      table.insert(code_lines, line)
    end
  end
  local code = table.concat(code_lines, "\n")

  -- Include cell-options defaults
  -- for k, v in pairs(cell_options[engine]) do
  --  attr[k] = v
  -- end

  -- Parse quarto-style yaml attributes
  local param_yaml = table.concat(param_lines, "\n")
  if (param_yaml ~= "") then
    param_attr = tinyyaml.parse(param_yaml)
    for k, v in pairs(param_attr) do
      attr[k] = v
    end
  end

  -- Parse traditional knitr-style attributes
  for k, v in pairs(block.attributes) do
    local function toboolean(v)
      return string.lower(v) == "true"
    end

    local convert = {
      autorun = toboolean,
      runbutton = toboolean,
      echo = toboolean,
      edit = toboolean,
      error = toboolean,
      eval = toboolean,
      include = toboolean,
      output = toboolean,
      startover = toboolean,
      solution = toboolean,
      warning = toboolean,
      timelimit = tonumber,
      ["fig-width"] = tonumber,
      ["fig-height"] = tonumber,
    }

    if (convert[k]) then
      attr[k] = convert[k](v)
    else
      attr[k] = v
    end
  end

  -- When echo: false: disable the editor
  if (attr.echo == false) then
    attr.edit = false
  end

  -- When `include: false`: disable the editor, source block echo, and output
  if (attr.include == false) then
    attr.edit = false
    attr.echo = false
    attr.output = false
  end

  -- If we're not executing anything, there's no point showing an editor
  if (attr.edit == nil) then
    attr.edit = attr.eval
  end

  return {
    code = code,
    attr = attr
  }
end

function AdmCodeBlock(code)
  block_id = block_id + 1

  --local block = ParseBlock(code, "adm")

  out = pandoc.Div({
    attr = { class = "webr-adm-ext",
             id="e9-post-solution",
             style="visibility: hidden;" },
    content = {
      code
    }
  })

  return out
end

