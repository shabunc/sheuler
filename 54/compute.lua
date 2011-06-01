#!/usr/bin/env lua
package.path = package.path .. ";../modules/?.lua"

require("class")
require("numeric")
require("array")

local CARDS = {"2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"}

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
    return self.cards, self.cluster
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

        --[[
            High Card: Highest value card.
            One Pair: Two cards of the same value.
            Two Pairs: Two different pairs.
            Three of a Kind: Three cards of the same value.
            Straight: All cards are consecutive values.
            Flush: All cards of the same suit.
            Full House: Three of a kind and a pair.
            Four of a Kind: Four cards of the same value.
            Straight Flush: All cards are consecutive values of same suit.
            Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
        ]]
    local check = array{"hasRoyalFlush", "hasTwoPairs", "hasThreeOfAKind", "hasStraight", "hasFlush", "hasFullHouse", "hasFourOfAKind", "hasTwoPairs", "hasOnePair"}:map(function(func) 
        if self[func](self) then
            return 1
        end
        return 0
    end)    

    local rank = numeric.digits2num(check, 2)
    print(check, " => ", rank)

    return rank, CARDS[self.cluster[1][1]]
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

    local rank1, highest1 = player1:getRank()
    local rank2, highest2 = player2:getRank()
    print(rank1, rank2)
    print(highest1, highest2)

    local winner
    if rank1 > rank2 then
        winner = player1
    elseif rank1 < rank2 then
        winner = player2
    elseif highest1 > highest2 then
        winner = player1 
    else
        winner = player2
    end

    return winner
end

function Game:isFirstPlayer(player)
    return self.player1 == player
end

function Game:isSecondPlayer(player)
    return self.player2 == player
end

local game = Game(Player(), Player(), "5H 5C 6S 7S KD 2C 3S 8S 8D TD")
assert(game:isSecondPlayer(game:findWinner()) == true)

local game = Game(Player(), Player(), "5D 8C 9S JS AC 2C 5C 7D 8S QH")
assert(game:isFirstPlayer(game:findWinner()) == true)
