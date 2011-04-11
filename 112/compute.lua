#!/usr/bin/env lua 

package.path = package.path .. ";/Users/shabunc/mine/euler/modules/?.lua"

require("numeric")
require("array")

function get_bounce_type(t) 
    local is_asc = true
    local is_desc = true
    for j = 2, #t do 
        is_asc = is_asc and t[j] >= t[j-1]
        is_desc = is_desc and t[j] <= t[j-1]
        if not(is_desc or is_asc) then
            return false, false, true
        end
    end
    return is_asc, is_desc, false
end

function f(n, k) 
    if n == 0 then
        return 1
    end
    total = 0
    for j = k, 9 do
        total = total + f(n-1, j)
    end
    return total
end

function g(n, k) 
    if n == 0 then
        return 1
    end
    total = 0
    for j = 9 - k, 9 do
        total = total + g(n-1, j)
    end
    return total
end

function bounce_stat(from, dencity)
    local iterator = numeric.integer_iterator(from, 9998)
    local res = {[-1] = {}, [0] = {}, [1] = {}}
    local count = 0
    while true do
        num = iterator()
        if not num then
            break
        end
        local is_asc, is_desc, is_bouncing  = get_bounce_type(num)
        --print(btype, table.concat(num))
        if is_asc then
            table.insert(res[1], num)
        end
        if is_desc then
            table.insert(res[-1], num)
        end
        if is_bouncing then
            table.insert(res[0], num)
            --if #res[0]/count == dencity then
            if false then
                print("answer is ", table.concat(num))
                break
            end
        end
        count = count + 1
    end
    print("from ", table.concat(from), " to", count, "there are") 
    print("ascending => ",  #res[1])
    print("descending => ",  #res[-1])
    print("bouncing => ",  #res[0], #res[0]/count)
    print("non-bouncy", count - #res[0])
end

bounce_stat({1,0,0,0}, 0.99)
print(f(4,0))
print(g(4,0))
