pascal = {}

function pascal.divisibility_rule(m, len)
    local r = {1}
    local iterator
    len = len or m
    for j = 1,len do
        iterator = (10*r[#r]) % m
        table.insert(r, iterator)
    end
    return r 
end

function pascal.divisible(digits, n)
   local rules = pascal.divisibility_rule(n, #digits)
   local num = 0
   for j=1,#digits do
        num = num + digits[j]* rules[#digits - j + 1]
   end
   local remainder = num % n
   return remainder == 0, remainder
end

return pascal
