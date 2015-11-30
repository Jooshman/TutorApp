require 'test_helper'

class UserreviewsControllerTest < ActionController::TestCase
  setup do
    @userreview = userreviews(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:userreviews)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create userreview" do
    assert_difference('Userreview.count') do
      post :create, userreview: { body: @userreview.body, name: @userreview.name, userlogin_id: @userreview.userlogin_id }
    end

    assert_redirected_to userreview_path(assigns(:userreview))
  end

  test "should show userreview" do
    get :show, id: @userreview
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @userreview
    assert_response :success
  end

  test "should update userreview" do
    patch :update, id: @userreview, userreview: { body: @userreview.body, name: @userreview.name, userlogin_id: @userreview.userlogin_id }
    assert_redirected_to userreview_path(assigns(:userreview))
  end

  test "should destroy userreview" do
    assert_difference('Userreview.count', -1) do
      delete :destroy, id: @userreview
    end

    assert_redirected_to userreviews_path
  end
end
