#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("class")
require("numeric")
require("array")

local CARDS = {2, 3, 4, 5, 6, 7, 8, 9, "T", "J", "Q", "K", "A"}

Player = class:new()
function Player:init()
    self.cards = array{}
end

function Player:addCard(card)
    table.insert(self.cards, self:parseCard(card))
end

function Player:parseCard(card)
    return {
        value = array.index_of(CARDS, card:sub(1, 1)),
        suid = card: sub(2, 1)
    }
end

function Player:isReady()
    return #self.cards == 5
end

function Player:sort()
    table.sort(self.cards, function(a, b) return a.value < b.value end)
end

function Player:hasRoyalFlush()
    return self:hasStraightFlush() and self.cards[1].value == "T"
end

function Player:hasStraightFlush()
    return self:hasFlush() and self:hasSameSuit()
end

function Player:hasFourOfAKind()
    local cluster = self:cluster()
    return cluster[1][2] == 4
end

function Player:hasFullHouse()
    local cluster = self:cluster()
    return cluster[1][2] == 3 and cluster[2][2] == 2
end


function Player:hasFlush()
    for j = 2, #self.cards do
        if self.cards[j].suit ~= self.cards[1] then
            return false
        end
    end
    return true
end

function Player:hasStraight()
    for j = 2, #self.cards do
        if (self.cards[j] - self.cards[j - 1]) ~= 1 then
            return false
        end
    end
    return true
end

function Player:hasTwoPairs()
    local cluster = self:cluster()
    return cluster[1][2] == 2 and cluster[2][2] == 2
end

function Player:hasOnePair()
    local cluster = self:cluster()
    return cluster[1][2] == 2
end

function Player:highestCard()
    return self.cards[#self.cards] 
end

function Player:cluster()
    local uniq = {{self.cards[1].value, 1}}
    for j = 2, #self.cards do
        if self.cards[j].value ~= self.cards[j - 1].value then
             table.insert(uniq, {self.cards[j].value, 1})
        else
            uniq[#uniq][2] = uniq[#uniq][2] + 1
        end
    end
    table.sort(uniq, function(a, b) return a[2] > b[2] end)
    return uniq
end
