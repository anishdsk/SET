require_relative "cardClass"

class Deck

    attr_accessor :cards;
    attr_accessor :cardsOnTable;

    def initialize()
        # creates arrays to hold all the possible options for card attributes
        colorOptions = Array['Red','Green', 'Purple']
        shadeOptions = Array['Solid', 'Striped', 'Outlined']
        shapeOptions = Array['Oval', 'Squiggle', 'Diamond']
        numOptions = Array(1..3)
        identifierOptions = Array(100..181)
        
        # hold generated Cards
        @cards = Array.new
        # holds cards taken from deck and dealt
        @cardsOnTable = Array.new

        # create every card combination for a Set game deck 
        i = 0
        colorOptions.each{ |color|
            shadeOptions.each { |shade|
                shapeOptions.each { |shape|
                    numOptions.each { |num|
                        # card generated from a combination
                        generatedCard = Card.new(color, shade, shape, num, identifierOptions[i])
                        @cards.append(generatedCard)
                        i += 1
                    }
                }
            }
        }
    end

    # scrambles the array of cards (shuffle)
    def shuffle
        @cards.shuffle!
    end

    # puts cards from deck onto "table"; deals them
    def putOnTable
        # take the 12 cards on top of the deck and deal on "table"
        @cardsOnTable = @cards[0..11]
        12.times{@cards.shift}
    end

    # subtract cards picked by the user from the "table" 
    def subtractSet(chosenCards)
        @cardsOnTable.each { |c|
            if c = chosenCards[0]
                @cardsOnTable.delete_at(0)
            elsif c = chosencards[1]
                @cardsOnTable.delete_at(1)
            elsif c = chosenCards[2]
                @cardsOnTable.delete_at(2)
            end
        }
    end

    # replaces the three set cards on the table with three new cards
    def replaceThree
        # move cards from deck to cardsOnTable
        3.times{ |c|
            @cardsOnTable.push(@cards.at(c))
        }
        # subtract 3 cards from deck
        3.times{cards.shift}
    end
end