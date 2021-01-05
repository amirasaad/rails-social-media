require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase

  def setup
    sign_in users(:morty)
  end

  test "morty should edit only their profile" do
    get :edit, params: { id: profiles(:morty_profile).id }
    assert_response :success
  end

end
