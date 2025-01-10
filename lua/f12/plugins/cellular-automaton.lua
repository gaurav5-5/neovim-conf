return {
  'eandrju/cellular-automaton.nvim',
  config = function()
    vim.keymap.set('n', '<leader>fml', function()
      local opts = {
        'make_it_rain',
        'game_of_life',
        'slide',
      }
      vim.cmd.CellularAutomaton(opts[math.random(3)])
    end, { desc = 'FML' })

    local config = {
      fps = 50,
      name = 'slide',
    }
    -- update function
    config.update = function(grid)
      for i = 1, #grid do
        local prev = grid[i][#grid[i]]
        for j = 1, #grid[i] do
          grid[i][j], prev = prev, grid[i][j]
        end
      end
      return true
    end

    require('cellular-automaton').register_animation(config)
  end,
}
