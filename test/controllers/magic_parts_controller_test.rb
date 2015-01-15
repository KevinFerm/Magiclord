require 'test_helper'

class MagicPartsControllerTest < ActionController::TestCase
  setup do
    @magic_part = magic_parts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:magic_parts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create magic_part" do
    assert_difference('MagicPart.count') do
      post :create, magic_part: { effect: @magic_part.effect, title: @magic_part.title, type: @magic_part.type }
    end

    assert_redirected_to magic_part_path(assigns(:magic_part))
  end

  test "should show magic_part" do
    get :show, id: @magic_part
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @magic_part
    assert_response :success
  end

  test "should update magic_part" do
    patch :update, id: @magic_part, magic_part: { effect: @magic_part.effect, title: @magic_part.title, type: @magic_part.type }
    assert_redirected_to magic_part_path(assigns(:magic_part))
  end

  test "should destroy magic_part" do
    assert_difference('MagicPart.count', -1) do
      delete :destroy, id: @magic_part
    end

    assert_redirected_to magic_parts_path
  end
end
