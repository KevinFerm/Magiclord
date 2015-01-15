require 'test_helper'

class PearlsControllerTest < ActionController::TestCase
  setup do
    @pearl = pearls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pearls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pearl" do
    assert_difference('Pearl.count') do
      post :create, pearl: { effect: @pearl.effect, ep: @pearl.ep, item_id: @pearl.item_id, parts: @pearl.parts, title: @pearl.title, type: @pearl.type }
    end

    assert_redirected_to pearl_path(assigns(:pearl))
  end

  test "should show pearl" do
    get :show, id: @pearl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pearl
    assert_response :success
  end

  test "should update pearl" do
    patch :update, id: @pearl, pearl: { effect: @pearl.effect, ep: @pearl.ep, item_id: @pearl.item_id, parts: @pearl.parts, title: @pearl.title, type: @pearl.type }
    assert_redirected_to pearl_path(assigns(:pearl))
  end

  test "should destroy pearl" do
    assert_difference('Pearl.count', -1) do
      delete :destroy, id: @pearl
    end

    assert_redirected_to pearls_path
  end
end
