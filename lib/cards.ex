defmodule Cards do
@moduledoc """
  Provides methods for creating and handling a deck of cards
"""
  @doc """
    Returns a list of strings representing a deck of playing cards
  """
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
  @doc """
    Creates a new list of cards that are shuffled
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns a boolean that determines if a card is contained within a deck

  ## Examples
        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Five of Diamond")
        false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Returns a tuple where the first list is a list representing a hand and the second list are the remaining cards

  ## Example:
        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]
  """
  def deal(deck, hand) do
    Enum.split(deck, hand)
  end

  @doc """
    Saves the file to our filesystem
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a file in our filesystem
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end
  @doc """
  Returns a tuple where the first list is the hand the second are the remaining cards
  """
  def create_hand(hand) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand)
  end
end
