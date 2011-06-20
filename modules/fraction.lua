require("array")
require("class")
require("numeric")

fraction = class:new()

function fraction:init(a, b) 
    self.a = a
    self.b = b
end

function fraction:__tostring()
    return "" .. self.a .. "/" .. self.b
end

function fraction:reduce() 
    local a, b = self.a, self.b
    local ra, rb = a, b
    local n = math.min(a, b)
    for j = 1, n do
        if a % j == 0 and b % j == 0 then
            ra = a / j
            rb = b / j
        end
    end
    self.a, self.b = ra, rb
    return self
end
