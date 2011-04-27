#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("class")

ClassA = class:new()

function ClassA:ping()
    return "ClassA:ping"
end

function ClassA:pong()
    return "ClassA:pong"
end

a = ClassA:new()
assert(a:ping() == "ClassA:ping")
assert(a:pong() == "ClassA:pong")

ClassB = class:new(ClassA)
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
