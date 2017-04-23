require 'test_helper'

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "garth", email: "brooksy4503@gmail.com",password: "password",
                          password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "john", email: "john@example.com",password: "password",
                          password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "john1", email: "john1@example.com.com",password: "password",
                          password_confirmation: "password", admin: true)
  end
   
  test "reject an invalid edit" do
    sign_in_as(@chef,"password")
    get edit_chef_path(@chef)
    patch chef_path(@chef), params: { chef: { chefname: " ", email: "brooksy4503@gmail.com"}}
    assert_template 'chefs/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "Accept valid edit" do
      sign_in_as(@chef,"password")
      get edit_chef_path(@chef)
      assert_template 'chefs/edit'
      patch chef_path(@chef), params: { chef: { chefname: "garth", email: "brooksy4503@gmail.com" } }
      assert_redirected_to @chef
      assert_not flash.empty?
      @chef.reload
      assert_match "garth", @chef.chefname
      assert_match "brooksy4503@gmail.com", @chef.email

  
  end
  
  test "accept edit attempt by admin user" do
      sign_in_as(@admin_user,"password")
      get edit_chef_path(@chef)
      assert_template 'chefs/edit'
      patch chef_path(@chef), params: { chef: { chefname: "garth2", email: "garth2@example.com" } }
      assert_redirected_to @chef
      assert_not flash.empty?
      @chef.reload
      assert_match "garth2", @chef.chefname
      assert_match "garth2@example.com", @chef.email    
    
  end
  
  test "redirect edit attempt by another non-admin user" do
      sign_in_as(@chef2,"password")
      updated_name = "joe"
      updated_email = "joe@example.com"
      patch chef_path(@chef), params: { chef: { chefname: updated_name, email: updated_email } }
      assert_redirected_to chefs_path
      assert_not flash.empty?
      @chef.reload
      assert_match "garth", @chef.chefname
      assert_match "brooksy4503@gmail.com", @chef.email        
  end
end
