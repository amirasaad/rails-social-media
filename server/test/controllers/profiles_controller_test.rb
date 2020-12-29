require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:morty)
  end

  test "morty should edit only their profile" do
    get :edit , id: profiles(:morty_profile).id
    assert_response :success
  end

  test "morty should not edit rick profile" do
    get :edit , id: profiles(:rick_profile).id
    assert_response :redirect
  end

end
