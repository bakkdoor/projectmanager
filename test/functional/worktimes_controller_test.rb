require 'test_helper'

class WorktimesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:worktimes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_worktime
    assert_difference('Worktime.count') do
      post :create, :worktime => { }
    end

    assert_redirected_to worktime_path(assigns(:worktime))
  end

  def test_should_show_worktime
    get :show, :id => worktimes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => worktimes(:one).id
    assert_response :success
  end

  def test_should_update_worktime
    put :update, :id => worktimes(:one).id, :worktime => { }
    assert_redirected_to worktime_path(assigns(:worktime))
  end

  def test_should_destroy_worktime
    assert_difference('Worktime.count', -1) do
      delete :destroy, :id => worktimes(:one).id
    end

    assert_redirected_to worktimes_path
  end
end
