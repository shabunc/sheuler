bignum = {}

function bignum.adddigits(a,b)
    if a > 9 or b > 9 then error("incorrect number") end
    local res = a + b
    if res > 9 then 
        return {1, res % 10}
    else
        return {res}
    end
end

function bignum.add(a, b) 
    if #b > #a then
        a, b = b, a
    end
end

function bignum.multiply(a, b)

end

return bignum
