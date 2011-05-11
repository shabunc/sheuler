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
    local cluster = {{self.cards[1].value, 1}}
    for j = 2, #self.cards do
        if self.cards[j].value ~= self.cards[j - 1].value then
             table.insert(cluster, {self.cards[j].value, 1})
        else
            cluster[#cluster][2] = cluster[#cluster][2] + 1
        end
    end
    table.sort(cluster, function(a, b) return a[2] > b[2] end)
    self.cluster = cluster
    return self.cards, self.luster
end

function Player:hasRoyalFlush()
    return self:hasStraightFlush() and self.cards[1].value == "T"
end

function Player:hasStraightFlush()
    return self:hasFlush() and self:hasSameSuit()
end

function Player:hasFourOfAKind()
    return self.cluster[1][2] >= 4
end

function Player:hasThreeOfAKind()
    return self.cluster[1][2] >= 3
end

function Player:hasFullHouse()
    return self.cluster[1][2] >= 3 and self.cluster[2][2] >= 2
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
        if (self.cards[j].value - self.cards[j - 1].value) ~= 1 then
            return false
        end
    end
    return true
end

function Player:hasTwoPairs()
    return self.cluster[1][2] >= 2 and self.cluster[2][2] >= 2
end

function Player:hasOnePair()
    return self.cluster[1][2] >= 2
end

function Player:highestCard()
    return self.cards[#self.cards] 
end

function Player:getRank() 
    local rank = 0
    if self:hasOnePair() then
        rank = rank + 1
    end

    if self:hasTwoPairs() then
        rank = rank + 1
    end
    
    if self:hasThreeOfAKind() then
        rank = rank + 1
    end

    if self:hasStraight() then
        rank = rank + 1
    end

    if self:hasFlush() then
        rank = rank + 1
    end

    if self:hasFullHouse() then
        rank = rank + 1
    end

    if self:hasFourOfAKind() then
        rank = rank + 1
    end

    if self:hasStraightFlush() then
        rank = rank + 1
    end

    if self:hasRoyalFlush() then
        rank = rank + 1
    end

    return rank
end

Game = class:new()
function Game:init(player1, player2, data)
    local count = 1
    local player = player1
    for card in data:gmatch("%w%w") do
        player:addCard(card)
        if count == 5 then
            player = player2
        end
        count = count + 1
    end

    assert(player1:isReady())
    assert(player2:isReady())

    player1:sort()
    player2:sort()
    
    self.player1 = player1
    self.player2 = player2
end

function Game:findWinner() 
    local player1 = self.player1
    local player2 = self.player2

    local rank1 = player1:getRank()
    local rank2 = player2:getRank()
    print(rank1, rank2)

    local winner
    if rank1 > rank2 then
        winner = player1
    elseif rank1 < rank2 then
        winner = player2
    else
        winner = self:playerWithHighestCard()
    end

    return winner
end

function Game:isFirstPlayer(player)
    return self.player1 == player
end

function Game:isSecondPlayer(player)
    return self.player2 == player
end

function Game:playerWithHighestCard()
    local player1 = self.player1
    local player2 = self.player2

    if player2.cards[#player2.cards].value > player1.cards[#player1.cards].value then
        return player2
    end
    return player1
end

local game = Game(Player(), Player(), "5H 5C 6S 7S KD 2C 3S 8S 8D TD")
if game:isFirstPlayer(game:findWinner())  then
    print("PLAYER1")
else
    print("PLAYER2")
end
