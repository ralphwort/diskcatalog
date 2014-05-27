require 'test_helper'

class FileListsControllerTest < ActionController::TestCase
  setup do
    @file_list = file_lists(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:file_lists)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create file_list" do
    assert_difference('FileList.count') do
      post :create, file_list: { disk: @file_list.disk, filename: @file_list.filename }
    end

    assert_redirected_to file_list_path(assigns(:file_list))
  end

  test "should show file_list" do
    get :show, id: @file_list
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @file_list
    assert_response :success
  end

  test "should update file_list" do
    patch :update, id: @file_list, file_list: { disk: @file_list.disk, filename: @file_list.filename }
    assert_redirected_to file_list_path(assigns(:file_list))
  end

  test "should destroy file_list" do
    assert_difference('FileList.count', -1) do
      delete :destroy, id: @file_list
    end

    assert_redirected_to file_lists_path
  end
end
