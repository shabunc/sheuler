pascal = {}

function pascal.divisibility_rule(m)
    local r = {10 % m}
    local iterator
    while true do
        iterator = (10*r[#r]) % m
        if iterator == r[1] or iterator == r[#r]  then
            break
        else
            table.insert(r, iterator)
        end
    end
    return r
end

return pascal

