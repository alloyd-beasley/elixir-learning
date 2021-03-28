defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "shuffle shuffles a deck" do
    deck = ["Ace of Spades", "2 of Spades", "3 of Spades", "4 of Spades", "5 of Spades",
    "Ace of Clubs", "2 of Clubs", "3 of Clubs", "4 of Clubs", "5 of Clubs",
    "Ace of Hearts", "2 of Hearts", "3 of Hearts", "4 of Hearts", "5 of Hearts",
    "Ace of Diamonds", "2 of Diamonds", "3 of Diamonds", "4 of Diamonds",
    "5 of Diamonds"]

    assert Cards.shuffle(deck) != deck
  end

  test "create_hand creates deck, shuffles deck, deals from deck" do
    base_deck = ["Ace of Spades", "2 of Spades", "3 of Spades", "4 of Spades", "5 of Spades",
    "Ace of Clubs", "2 of Clubs", "3 of Clubs", "4 of Clubs", "5 of Clubs",
    "Ace of Hearts", "2 of Hearts", "3 of Hearts", "4 of Hearts", "5 of Hearts",
    "Ace of Diamonds", "2 of Diamonds", "3 of Diamonds", "4 of Diamonds",
    "5 of Diamonds"]

    hand = Cards.create_hand(1)
    

    assert Cards.contains?("Ace of Spades") != false
  end
end
