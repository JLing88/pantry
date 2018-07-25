require './lib/pantry'
require './lib/recipe'
require 'minitest/autorun'
require 'minitest/pride'

class PantryTest < Minitest::Test

  def setup
    @pantry = Pantry.new
  end

  def test_it_exists
    assert_instance_of Pantry, @pantry
  end

  def test_stock_is_empty_by_default
    assert @pantry.stock.empty?
  end

  def test_it_can_find_items_in_stock
    assert_equal 0, @pantry.stock_check("Cheese")
  end

  def test_it_can_restock_items
    @pantry.restock("Sour Cream", 10)
    assert_equal 10, @pantry.stock_check("Sour Cream")
    @pantry.restock("Sour Cream", 30)
    assert_equal 40, @pantry.stock_check("Sour Cream")
  end

  def test_it_can_add_ingredients_to_shopping_list
    assert @pantry.shopping_list.empty?
    r = Recipe.new("Cheese Pizza")
    r.add_ingredient("Cheese", 20)
    r.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(r)
    expected = {"Cheese" => 20, "Flour" => 20}
    assert_equal expected, @pantry.shopping_list
  end

  def test_it_can_add_multiple_recipes_to_shopping_list
    assert @pantry.shopping_list.empty?
    r_1 = Recipe.new("Cheese Pizza")
    r_1.add_ingredient("Cheese", 20)
    r_1.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(r_1)
    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Spaghetti Noodles", 10)
    r_2.add_ingredient("Marinara Sauce", 10)
    r_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(r_2)
    expected = {"Cheese" => 25,
                "Flour" => 20,
                "Spaghetti Noodles" => 10,
                "Marinara Sauce" => 10}
    assert_equal expected, @pantry.shopping_list
  end

  def test_it_can_print_shopping_list
    r_1 = Recipe.new("Cheese Pizza")
    r_1.add_ingredient("Cheese", 20)
    r_1.add_ingredient("Flour", 20)
    @pantry.add_to_shopping_list(r_1)
    r_2 = Recipe.new("Spaghetti")
    r_2.add_ingredient("Spaghetti Noodles", 10)
    r_2.add_ingredient("Marinara Sauce", 10)
    r_2.add_ingredient("Cheese", 5)
    @pantry.add_to_shopping_list(r_2)
    expected = "* Cheese: 25\n* Flour: 20\n* Spaghetti Noodles: 10\n* Marinara Sauce: 10"
    assert_equal expected, @pantry.print_shopping_list
  end

  def test_it_can_add_to_cookbook
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    @pantry.add_to_cookbook(r1)
    @pantry.add_to_cookbook(r2)
    @pantry.add_to_cookbook(r3)
    expected = [r1, r2, r3]
    assert_equal expected, @pantry.cookbook
  end

  def test_it_can_tell_me_what_i_can_make
    r1 = Recipe.new("Cheese Pizza")
    r1.add_ingredient("Cheese", 20)
    r1.add_ingredient("Flour", 20)
    r2 = Recipe.new("Pickles")
    r2.add_ingredient("Brine", 10)
    r2.add_ingredient("Cucumbers", 30)
    r3 = Recipe.new("Peanuts")
    r3.add_ingredient("Raw nuts", 10)
    r3.add_ingredient("Salt", 10)
    @pantry.add_to_cookbook(r1)
    @pantry.add_to_cookbook(r2)
    @pantry.add_to_cookbook(r3)
    @pantry.restock("Cheese", 10)
    @pantry.restock("Flour", 20)
    @pantry.restock("Brine", 40)
    @pantry.restock("Cucumbers", 120)
    @pantry.restock("Raw nuts", 20)
    @pantry.restock("Salt", 20)
    assert_equal ["Pickles", "Peanuts"], @pantry.what_can_i_make
  end
end
