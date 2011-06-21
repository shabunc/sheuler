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
    local hcf = numeric.HCF(self.a, self.b)
    self.a = self.a / hcf
    self.b = self.b / hcf
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
