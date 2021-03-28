defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards.
  """

  @doc """
  """

  @doc """
  Generate list of playing cards

  ## Examples
    iex> deck = Cards.create_deck

    ["Ace of Spades", "2 of Spades", "3 of Spades", "4 of Spades", "5 of Spades",
    "Ace of Clubs", "2 of Clubs", "3 of Clubs", "4 of Clubs", "5 of Clubs",
    "Ace of Hearts", "2 of Hearts", "3 of Hearts", "4 of Hearts", "5 of Hearts",
    "Ace of Diamonds", "2 of Diamonds", "3 of Diamonds", "4 of Diamonds",
    "5 of Diamonds"]
  """
  def create_deck do
    ## Convention is to use double quotes
    values = ["Ace", "2", "3", "4", "5"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    ## For every element in the list, do this thing
    ## Comprehension is inherently a map
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffle a deck of cards.

  Accepts a `deck` to shuffle.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
   Find a card in the deck.

   Accepts a `deck` and a `card` to search for.

   ## Examples
   iex> deck = Cards.create_deck
   iex> Cards.contains?(deck, "Ace of Spades")
   true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Deal cards from a deck.

  Acceps a `deck` and a `hand_size` to deal.

  ## Examples
   iex> deck = Cards.create_deck
   iex> {hand, deck} = Cards.deal(deck, 1)
   iex> hand
   ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Create, shuffle, and deal a hand of cards

  Accepts the `size` of the hand.
  """
  def create_hand(size) do
    # use piping to chain methods
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(size)

    # Piping will influence how you write methods because it encourages taking consistent first arguments.
  end

  @doc """
  Save a deck of cards

  Accepts a `deck` and a `filename` for the deck that you want to save.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Load a saved deck of cards

  Accepts a `filename` to load.
  """
  def load(filename) do
    # pattern match from File.read, handle status in case statement
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist."
    end
  end
end
