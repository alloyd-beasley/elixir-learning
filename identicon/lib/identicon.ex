defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.

    Generates an identicon based on a string input.
  """

  @doc """
  Main entry and pipeline of the application.

  Accepts an `input` string.
  """
  def main(input) do
    input
    |> hash_string
    |> pick_color
    |> build_grid
    |> filter_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
  Converts a string into a hash.

  Accepts an `input` string.
  """
  def hash_string(input) do
    # convert input to hash
    # convert hash to byte array
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  @doc """
  Picks color based on first three values of binary list.

  Accepts an `image` struct.
  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # match for first 3 values of list, indicate that we do not want the rest of the list with | _tail
    # have to acknowlege that the list has more than 3 values
    # create new image struct with new value for color.
    %Identicon.Image{image | color: {r, g, b}}
  end

  @doc """
  Builds the image grid.

  Accepts an `image` struct.
  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    # pattern match the hex list
    # get lists of 3
    # mirror the lists
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Mirrors a row,
    [145, 26, 200]
    [145, 26, 200, 26, 145]

  Accepts a `row` to mirror.
  """
  def mirror_row(row) do
    # match first two values from row
    [first, second | _tail] = row

    # append to the row
    row ++ [second, first]
  end

  @doc """
  Filter odd squares from the grid/

  Accepts an `Image`.
  """
  def filter_squares(%Identicon.Image{grid: grid} = image) do
    grid = Enum.filter(grid, fn {v, _index} = s -> rem(v, 2) == 0 end)

    %Identicon.Image{image | grid: grid}
  end

  @doc """
  Builds grid of areas to be colored

  Accepts an `Image`.
  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_v, i} ->
        x = rem(i, 5) * 50
        y = div(i, 5) * 50
        top_left = {x, y}
        bottom_right = {x + 50, y + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
  Use erlang graphical drawer to create and render our grid

  Accepts an `Image`.
  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :egd.filledRectangle(image, start, stop, fill)
    end)

    :egd.render(image)
  end

  @doc """
  Save an image to the disk

  Accepts an `image` and an `input` for the file name.
  """
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end
end
