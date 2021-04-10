require_relative "cardClass"
require_relative "deckClass"

puts "\nWELCOME TO SET"
puts "This version is turn based and involves two players."
puts ""

print "Player 1, enter your name: "
name1 = gets.chomp
print "Player 2, enter your name: "
name2 = gets.chomp
puts ""

# set starting score to zero for both players
players = {name1 => 0, name2 => 0}

# creates a new deck
deck = Deck.new

# shuffles deck and puts 12 cards face up to the players
deck.shuffle
deck.putOnTable

# checks to see which player's turn it is. Starts with player 1
player1 = true
turnsToNotDraw = 0

# By rule, game ends when deck is depleted even if some cards are still on the "table"
while deck.cards.length() > 0
    # checks to make sure a valid set exists among displayed cards
    # if not, draws three more cards
    isSet = false
    while isSet == false
        deck.cardsOnTable.combination(3).to_a.each { |card|
            if ((card[0].color == card[1].color) && (card[1].color == card[2].color)) || ((card[0].color != card[1].color) && (card[0].color != card[2].color) && (card[1].color != card[2].color))
                if (card[0].shading == card[1].shading) && (card[1].shading == card[2].shading) || ((card[0].shading != card[1].shading) && (card[0].shading != card[2].shading) && (card[1].shading != card[2].shading))
                    if (card[0].shape == card[1].shape) && (card[1].shape == card[2].shape) || ((card[0].shape != card[1].shape) && (card[0].shape != card[2].shape) && (card[1].shape != card[2].shape))
                        if (card[0].number == card[1].number) && (card[1].number == card[2].number) || ((card[0].number != card[1].number) && (card[0].number != card[2].number) && (card[1].number != card[2].number))
                            isSet = true
                        end
                    end
                end
            end
        }
        if isSet == false
            cardsOnTable = cards[0..2]
            3.times{@cards.shift}
            # makes sure extra cards are not drawn for the remaining turns until cards on table reduces back to 12
            turnsToNotDraw += 1
        end
    end

    # displays cards for a player's turn
    deck.cardsOnTable.each { |card|
        puts card.displayCard
    }

    puts "Player 1, it's your turn." if player1 == true
    puts "Player 2, it's your turn." if player1 == false

    print "Type the three-digit IDs, without '#', of the cards you think form a set. Or press 'q' to end the game early: "
    identifierString = gets.chomp
    puts ""
    # end game early and add up scores if a player hits "q"
    break if identifierString.eql?("q")

    # stores the card identifiers
    identifiers = identifierString.split(" ")
    # holds card objects picked by user based on identifier
    chosenCards = Array.new
    # checks to make sure set chosen by user has 3 cards
    setCount = 0

    # checks if cards picked by user are on the "table"
    deck.cardsOnTable.each { |card|
        if card.identifier == identifiers[0].to_i
            chosenCards.append(card)
            setCount += 1
        elsif card.identifier == identifiers[1].to_i
            chosenCards.append(card)
            setCount += 1
        elsif card.identifier == identifiers[2].to_i
            chosenCards.append(card)
            setCount += 1
        end
    }

    # checks if chosen cards form a set
    correctness = false
    if setCount == 3
        if ((chosenCards[0].color == chosenCards[1].color) && (chosenCards[1].color == chosenCards[2].color)) || ((chosenCards[0].color != chosenCards[1].color) && (chosenCards[0].color != chosenCards[2].color) && (chosenCards[1].color != chosenCards[2].color))
            if (chosenCards[0].shading == chosenCards[1].shading) && (chosenCards[1].shading == chosenCards[2].shading) || ((chosenCards[0].shading != chosenCards[1].shading) && (chosenCards[0].shading != chosenCards[2].shading) && (chosenCards[1].shading != chosenCards[2].shading))
                if (chosenCards[0].shape == chosenCards[1].shape) && (chosenCards[1].shape == chosenCards[2].shape) || ((chosenCards[0].shape != chosenCards[1].shape) && (chosenCards[0].shape != chosenCards[2].shape) && (chosenCards[1].shape != chosenCards[2].shape))
                    if (chosenCards[0].number == chosenCards[1].number) && (chosenCards[1].number == chosenCards[2].number) || ((chosenCards[0].number != chosenCards[1].number) && (chosenCards[0].number != chosenCards[2].number) && (chosenCards[1].number != chosenCards[2].number))
                        puts "Nice job, you formed a set. You've gained a point."
                        players[name1] += 1 if player1 == true
                        players[name2] += 1 if player1 == false
                        correctness = true 
                        # replace the chosen set from the table with three cards from the deck
                        if deck.cards.length > 3
                            deck.subtractSet(chosenCards)
                            # dont draw more cards if table has over 12
                            if turnsToNotDraw == 0
                                deck.replaceThree
                            else 
                                turnsToNotDraw -= 1
                            end
                        end
                    end
                end
            end
        end
    end

    # if cards did not form a set
    if correctness == false
        puts ""
        puts "Your choice of cards did not form a set. You've lost a point."
        players[name1] -= 1 if player1 == true
        players[name2] -= 1 if player1 == false
    end

    # clear your hand
    chosenCards.clear
    
    # game only continues until main deck has more than zero cards
    # if you subtract more cards than how many is in the deck,
    # then deck.length <= 0. So the deck must have atleast 4 cards
    if deck.cards.length <= 3 
        puts "The deck will be depleted with the removal of 3 cards."
        break
    end
    # moves to next player's turn
    player1 = !player1
    puts "Your turn is now over. Next player is up."
    puts ""
end

puts "The game is now over."
puts ""

puts "Player 1 has #{players[name1]} points. Player 2 has #{players[name2]} points."
# checks to see who wins
if players[name1] > players[name2]
    puts "Congratulations #{name1}! You win the game."
elsif players[name1] < players[name2]
    puts "Congratulations #{name2}! You win the game."
elsif players[name1] == players[name2]
    puts "Congratulations to both players! It's a tie."
end
