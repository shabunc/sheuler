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
    for j = 1, math.sqrt(n) do
        if a % j == 0 and b % j == 0 then
            ra = a / j
            rb = b / j
        end
    end
    self.a, self.b = ra, rb
    return self
end

function fraction.add(f1, f2) 
    return fraction(f1.a * f2.b + f1.b * f2.a, f1.b * f2.b):reduce()
end

function fraction.mul(f1, f2)
    return fraction(f1.a * f2.a, f1.b * f2.b):reduce()
end

function fraction:recip()
    return fraction(self.b, self.a):reduce()
end
