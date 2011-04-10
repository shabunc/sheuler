#!/usr/bin/env lua

function n_digits_card(n)
    if n == 1 then 
        return 9
    end
    local res = 10^n - 10^(n-1) - 1
    return res
end  

for j = 1,6 do
    print(j, n_digits_card(j))
end
