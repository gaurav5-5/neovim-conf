return {
  'kevinhwang91/nvim-hlslens',
  opts = {
    override_lens = function(render, posList, nearest, idx, relIdx)
      local sfw = vim.v.searchforward == 1
      local indicator, text, chunks
      local absRelIdx = math.abs(relIdx)
      if absRelIdx > 1 then
        indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
      elseif absRelIdx == 1 then
        indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
      else
        indicator = ''
      end

      local lnum, col = unpack(posList[idx])
      if nearest then
        local cnt = #posList
        if indicator ~= '' then
          text = ('[%s %d/%d]'):format(indicator, idx, cnt)
        else
          text = ('[%d/%d]'):format(idx, cnt)
        end
        chunks = { { ' ' }, { text, 'HlSearchLensNear' } }
      else
        text = ('[%s %d]'):format(indicator, idx)
        chunks = { { ' ' }, { text, 'HlSearchLens' } }
      end
      render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
    end,
  },
  keys = {
    {
      'n',
      [[<CMD>execute('normal! ' . v:count1 . 'n')<CR><CMD>lua require('hlslens').start()<CR>]],
      mode = 'n',
      desc = 'hlsle[n]s',
      noremap = true,
      silent = true,
    },

    {
      'N',
      [[<CMD>execute('normal! ' . v:count1 . 'N')<CR><CMD>lua require('hlslens').start()<CR>]],
      mode = 'n',
      desc = 'hlsle[N]s',
      noremap = true,
      silent = true,
    },

    {
      '*',
      [[*<CMD>lua require('hlslens').start()<CR>]],
      mode = 'n',
      desc = 'hlslen*',
      noremap = true,
      silent = true,
    },

    {
      '*',
      [[*<CMD>lua require('hlslens').start()<CR>]],
      mode = 'n',
      desc = 'hlslen*',
      noremap = true,
      silent = true,
    },

    {
      'g*',
      [[g*<CMD>lua require('hlslens').start()<CR>]],
      mode = 'n',
      desc = 'hlslen*',
      noremap = true,
      silent = true,
    },

    {
      '#',
      [[#<CMD>lua require('hlslens').start()<CR>]],
      mode = 'n',
      desc = 'hlslen*',
      noremap = true,
      silent = true,
    },

    {
      'g#',
      [[g#<CMD>lua require('hlslens').start()<CR>]],
      mode = 'n',
      desc = 'hlslen*',
      noremap = true,
      silent = true,
    },
  },
}
