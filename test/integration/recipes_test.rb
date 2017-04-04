require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
  @chef = Chef.create!(chefname: "garth", email: 'brooksy4503@gmail.com')
  @recipe = Recipe.create(name: "vegetable saute", description: "greate vegetable sautee, add vegetable and oil", chef: @chef)
  @recipe2 = @chef.recipes.build(name: "chicken saute", description: "great chicken dish")
  @recipe2.save
  end
  
  
  test "should get recipes index" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
   get recipes_path
   assert_template 'recipes/index'
   #assert_match @recipe.name, response.body
   assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
   #assert_match @recipe2.name, response.body
   assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end
  
  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
    
  end
   
  
  
  # test "the truth" do
  #   assert true
  # end
end
