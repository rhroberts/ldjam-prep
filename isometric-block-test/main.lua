-- I tried to picture clusters of information as they moved through the computer ...
the_grid = require("the_grid")

function love.load()
   grid = the_grid.load(400, 400, 32)
   -- maintain a separate table of only visible blocks
   -- iterate over this to draw, not the full grid
   visible_cells = {}
   for i = 1, grid.ysquares do
      visible_cells[i] = {}
   end
end

function love.update(dt)
end

function love.draw()
   for row_index, row in pairs(visible_cells) do
      for col_index, cell in pairs(row) do
         love.graphics.draw(cell.sprite, cell.quad, cell.x, cell.y)
      end
   end

end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then -- Versions prior to 0.10.0 use the MouseConstant 'l'
      print("click location", x, y)
      hitCell = grid:getHitCell(x, y)
      print("grid cell corner location", hitCell.x, hitCell.y)
      hitCell.visible = not hitCell.visible
      
      if hitCell.visible then
         visible_cells[hitCell.y_index][hitCell.x_index] = hitCell
      else
         visible_cells[hitCell.y_index][hitCell.x_index] = nil
      end
    end
 end

 function screenSpaceToIsometric(x, y)
 end
