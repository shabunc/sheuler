#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("class")

--[[
--]]
ClassA = class:new()

print("starting inheritance tests\t...")
function ClassA:ping()
    return "ClassA:ping"
end

function ClassA:pong()
    return "ClassA:pong"
end

a = ClassA:new()
assert(a:ping() == "ClassA:ping")
assert(a:pong() == "ClassA:pong")

ClassB = ClassA:new()
function ClassB:ping()
    return "ClassB:ping"
end

b = ClassB:new()
assert(b:ping() == "ClassB:ping")
assert(b:pong() == "ClassA:pong")

ClassC = ClassB:new()
function ClassC:pong()
    return "ClassC:pong"
end

c = ClassC:new()
assert(c:ping(), "ClassB:ping")
assert(c:pong(), "ClassC:pong")

print("inheritance tests", "OK")

print("__tostring tests\t...")
ClassS = class:new()
function ClassS:__tostring()
    return "~~ClassS~~"
end

function ClassA:__tostring()
    return "~~ClassA~~"
end

function ClassC:__tostring()
    return "~~ClassC~~"
end
s = ClassS:new()
a = ClassA:new()
b = ClassB:new()
c = ClassC:new()
assert(tostring(s) == "~~ClassS~~")
assert(tostring(a) == "~~ClassA~~")
assert(tostring(b) == "~~ClassA~~")
assert(tostring(c) == "~~ClassC~~")
print("__tostring tests", "OK")

print("own properties and __eq tests\t...")
function ClassA:init(name) 
    self.name = name
end

function ClassA:__eq(b)
    return self.name == b.name
end
a = ClassA("shabunc")
b = ClassB("shahen")
c = ClassC("shabunc")

assert(a.name == "shabunc")
assert(a == c)
assert(a ~= b)
assert(c == a)
print("own properties and __eq tests\tOK")

print("all the tests are OK")
