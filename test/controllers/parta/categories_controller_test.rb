require 'test_helper'

class Parta::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parta_category = parta_categories(:one)
  end

  test "should get index" do
    get parta_categories_url
    assert_response :success
  end

  test "should get new" do
    get new_parta_category_url
    assert_response :success
  end

  test "should create parta_category" do
    assert_difference('Parta::Category.count') do
      post parta_categories_url, params: { parta_category: { description: @parta_category.description, name: @parta_category.name } }
    end

    assert_redirected_to parta_category_url(Parta::Category.last)
  end

  test "should show parta_category" do
    get parta_category_url(@parta_category)
    assert_response :success
  end

  test "should get edit" do
    get edit_parta_category_url(@parta_category)
    assert_response :success
  end

  test "should update parta_category" do
    patch parta_category_url(@parta_category), params: { parta_category: { description: @parta_category.description, name: @parta_category.name } }
    assert_redirected_to parta_category_url(@parta_category)
  end

  test "should destroy parta_category" do
    assert_difference('Parta::Category.count', -1) do
      delete parta_category_url(@parta_category)
    end

    assert_redirected_to parta_categories_url
  end
end
