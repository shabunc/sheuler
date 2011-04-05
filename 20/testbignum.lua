#!/usr/bin/env lua

require "bignum"

function test_adddigits(a,b,_a,_b)
    local res = bignum.adddigits(a,b)
    assert(res[1] == _a)
    assert(res[2] == _b)
end

test_adddigits(2,2,4,nil)
test_adddigits(7,5,1,2)
test_adddigits(9,9,1,8)

