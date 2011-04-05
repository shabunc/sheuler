#!/usr/bin/env lua

function dumb()
    local a, b = 0, 9
    local NTH = 1000000
    local counter = 0
    for a0 = a, b do 
        for a1 = a, b do 
            if a1 ~= a0 then
            for a2 = a, b do 
                if a2 ~= a1 and a2 ~= a0 then
                for a3 = a, b do
                    if a3 ~= a2 and a3 ~= a1 and a3 ~= a0 then
                    for a4 = a, b do 
                        if a4 ~= a3 and a4 ~= a2 and a4 ~= a1 and a4 ~= a0 then
                        for a5 = a, b do
                            if a5 ~= a4 and a5 ~= a3 and a5 ~= a2 and a5 ~= a1 and a5 ~= a0 then
                            for a6 = a, b do
                                if a6 ~= a5 and a6 ~= a4 and a6 ~= a3 and a6 ~= a2 and a6 ~= a1 and a6 ~= a0 then
                                for a7 = a, b do 
                                    if a7 ~= a6 and a7 ~= a5 and a7 ~= a4 and a7 ~= a3 and a7 ~= a2 and a7 ~= a1 and a7~= a0 then
                                    for a8 = a, b do
                                        if a8 ~= a7 and a8 ~= a6 and a8 ~= a5 and a8 ~= a4 and a8 ~= a3 and a8 ~= a2 and a8 ~= a1 and a8 ~= a0 then
                                        for a9 = a, b do 
                                            if a9 ~= a8 and a9 ~= a7 and a9 ~= a6 and a9 ~= a5 and a9 ~= a4 and a9 ~= a3 and a9 ~= a2 and a9 ~= a1 and a9 ~= a0 then
                                                counter = counter + 1
                                                if counter == NTH then
                                                    print(table.concat({a0,a1,a2,a3,a4,a5,a6,a7,a8,a9})) 
                                                    return 
                                                end
                                            end
                                        end
                                        end
                                    end
                                    end
                                end 
                                end
                            end
                            end
                        end
                        end
                    end
                    end
                end
                end
            end
            end
        end
    end
end

function copy(t) 
    local res = {}
    for j in ipairs(t) do
        res[j] = t[j]
    end
    return res
end

function recursive(t)
    local all = {}
    if #t == 1 then
        return {t}
    end 
    for j in ipairs(t) do
        local tail = copy(t)
        local head = table.remove(tail, j)
        local perms = recursive(tail)
        for i in ipairs(perms) do
            table.insert(perms[i], 1, head)
            table.insert(all, perms[i])
        end
    end
    return all
end

function next_permutation(permutation) 
    local k, l
    for j = 1, #permutation - 1 do 
        if permutation[j] < permutation[j+1] then
            k = j
        end
    end
    if not k then
        return false
    end
    for j = k + 1, #permutation do
        if permutation[j] > permutation[k] then
            l = j
        end
    end
    local swap = permutation[k]
    permutation[k] = permutation[l]
    permutation[l] = swap
    couroutine.yield(permutation)
    local reverted_tail = {}
    for j = k + 1, #permutation do
        reverted_tail[#reverted_tail + 1] = table.remove(permutation)
    end
    for j = 1, #reverted_tail do
        table.insert(reverted_tail[j])
    end
    couroutine.yield(permutation)
end


--dumb()
perms = recursive({0,1,2,3,4,5,6,7,8,9})
print(#perms)
print(table.concat(perms[1000000]))
