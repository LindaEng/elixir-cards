defmodule Cards do
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five "]
    suits = ["Spades", "Clubs", "Hearts", "Diamond"]

    # Method 1 to flatten array
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end

    # List.flatten(cards)


    # Method 2 - comprehension syntax
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand) do
    Enum.split(deck, hand)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand)
  end
end
