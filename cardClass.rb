class Card

    attr_accessor :color;
    attr_accessor :shading;
    attr_accessor :shape;
    attr_accessor :number;
    attr_accessor :identifier;

    def initialize(color, shading, shape, number, identifier)
        @color = color
        @shading = shading
        @shape = shape
        @number = number
        # added identifier to make life easier for player
        # when typing what cards they think form a set
        # as they can just type the card identifier than a long string
        @identifier = identifier 
    end

    def displayCard()
        puts "[#{shape}, #{number}, #{shading}, #{color}, ##{identifier}]"
    end
end

