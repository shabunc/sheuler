#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("numeric")
require("array")
require("bignum")

function nextdig(head, lim)
    local dig
    local prevnum
    for j = 0, 9 do
        local num = bignum(head)
        table.insert(num, j)
        local test = array(num:mul(num), 1, #lim)
        if test == lim then
            break
        end
        prevnum = num
    end
    return prevnum, prevnum[#prevnum]
end

function root(n, precision)
    local lim = array(numeric.digits(n))
    local head = array(numeric.digits(math.floor(math.sqrt(n))))
    local dig
    for j = 1, precision do
       head, dig = nextdig(head, lim) 
    end
    table.remove(head, 1)
    return head
end

assert(tostring(root(2,98)) == "41421356237309504880168872420969807856967187537694807317667973799073247846210703885038753432764157")
