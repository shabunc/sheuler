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
        suit = card:sub(2,2)
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
    return self:hasFlush() and self:hasStraight()
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
        if self.cards[j].suit ~= self.cards[j - 1].suit then
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
    local checks = {
        "hasRoyalFlush",
        "hasStraightFlush",
        "hasFourOfAKind",
        "hasFullHouse",
        "hasFlush",
        "hasStraight",
        "hasThreeOfAKind",
        "hasTwoPairs",
        "hasOnePair"
    }

    local has, rank
    for i, v in ipairs(checks) do
        rank = i
        if self[v](self) then
            has = v
            break
        end
    end

    if not has then
        has = "hasHighestCard"
    end
    local highest_card
    if has == "hasRoyalFlush" or has == "hasStraightFlush" or has == "hasFlush" or has == "hasStraight" or has == "hasHighestCard" then
        highest_card = self:highestCard()
    else
        highest_card = self.cluster[1][1]
    end
    return rank, highest_card, has, CARDS[highest_card]
end

function Player:highestCard()
    return self.cards[#self.cards].value
end

Game = class:new()
function Game:init(player1, player2, data)
    print("game", data)
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

    local rank1, highest1, has1, major1 = player1:getRank()
    local rank2, highest2, has2, major2 = player2:getRank()

    local winner
    if rank1 < rank2 then
        winner = player1
    elseif rank1 > rank2 then
        winner = player2
    elseif highest1 > highest2 then
        winner = player1 
    elseif highest1 < highest2 then
        winner = player2
    else
        for j = #player2.cards, 1, -1 do
            if player1.cards[j].value > player2.cards[j].value then
                winner = player1
                break
            elseif player2.cards[j].value > player1.cards[j].value then
                winner = player2
                break
            end
        end
    end

    print(has1, major1)
    print(has2, major2)

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

local game = Game(Player(), Player(), " 2D 9C AS AH AC 3D 6D 7D TD QD")
assert(game:isSecondPlayer(game:findWinner()) == true)

local game = Game(Player(), Player(), "4D 6S 9H QH QC 3D 6D 7H QD QS")
assert(game:isFirstPlayer(game:findWinner()) == true)

local game = Game(Player(), Player(), "2H 2D 4C 4D 4S 3C 3D 3S 9S 9D")
assert(game:isFirstPlayer(game:findWinner()) == true)

function problem54(filename)
    local file = io.open(filename, "r")
    local total = 0
    for line in file:lines() do
        local game = Game(Player(), Player(), line)
        if game:isFirstPlayer(game:findWinner()) then
            total = total + 1
        end
    end
    print("TOTAL", total)
    return total
end

problem54("poker.txt")
