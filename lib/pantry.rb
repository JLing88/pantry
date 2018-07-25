require './lib/recipe'
require 'pry'

class Pantry

  attr_reader :stock,
              :shopping_list,
              :cookbook

  def initialize
    @stock = {}
    @shopping_list = {}
    @cookbook = []
  end

  def stock_check(item)
    if @stock.include?(item)
      @stock[item]
    else
      0
    end
  end

  def restock(item, quantity)
    if @stock.has_key?(item)
      @stock[item] += quantity
    else
      @stock[item] = quantity
    end
  end

  def add_to_shopping_list(recipe)
    recipe.ingredients.map do |ingredient, amount|
      if @shopping_list.has_key?(ingredient)
        @shopping_list[ingredient] += amount
      else
        @shopping_list[ingredient] = amount
      end
    end
  end

  def print_shopping_list
    array = @shopping_list.map do |ingredient, amount|
      "* #{ingredient}: #{amount}"
    end
    puts string = array.join("\n")
    string
  end

  def add_to_cookbook(recipe)
    @cookbook << recipe
  end

  def what_can_i_make
    makeable = []
    @cookbook.map do |recipe|
      if @stock.keys.include?(recipe.ingredients.keys)
        ###
      end
    end
  end
end
