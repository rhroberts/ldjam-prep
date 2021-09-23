require("math")

Grid = {}
GridCell = {}

function GridCell.new(x, y, x_index, y_index) 
    local new = {}
    new.x = x
    new.x_index = x_index
    new.y = y
    new.y_index = y_index

    -- probably split this out into block types,
    -- maybe even with operators defined by neighbors
    new.sprite = love.graphics.newImage("assets/iso_blocks.png")
    -- default to full block quad
    new.quad = love.graphics.newQuad(0, 0, 32, 32, new.sprite:getDimensions())

    new.visible = false
    setmetatable(new, {__index=GridCell})
    return new
end

function Grid.load(xdim, ydim, sidelength) 
    local grid = {}

    grid.xdim = xdim
    grid.ydim = ydim
    grid.xsquares = math.floor(xdim / sidelength)
    grid.ysquares = math.floor(ydim / sidelength)
    grid.sidelength = sidelength
    grid.cells = {}
    -- // row major
    print(grid.xsquares, grid.ysquares)
    for i=1, grid.ysquares do
        grid.cells[i] = {}
        for j=1, grid.xsquares do
            print("grid", i, j)
            print("grid upper left points", (i - 1) * sidelength, (j - 1) * sidelength)
            grid.cells[i][j] = GridCell.new((j - 1) * sidelength, (i - 1) * sidelength, j, i)
        end
    end

    setmetatable(grid, {__index=Grid})

    return grid
end

function Grid:getHitCell(x, y)
    local xindex = math.floor(x / self.sidelength) + 1
    local yindex = math.floor(y / self.sidelength) + 1

    if xindex > grid.xsquares or yindex > grid.ysquares then
        return {}
    end

    return self.cells[yindex][xindex]
end

return Grid