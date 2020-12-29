require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:morty)
    @post = posts(:morty_post)
  end

  test "should list posts" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { body: @post.body }
    end

    assert_redirected_to posts_path
  end

  test "should show post" do
    get :show, id: @post
    assert_response :success
  end

  test "morty should update their post" do
    patch :update, id: @post, post: { body: @post.body }
    assert_redirected_to root_url
  end

  test "morty should not update rick post" do

    patch :update, id: posts(:rick_post), post: {body: 'Yo son of a bi**'}

    assert_equal Post.get_primary_key(posts(:rick_post).body, posts(:rick_post).body)

    assert_redirected_to root_url
  end

  test "morty should destroy thier post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @post
    end

    assert_redirected_to posts_path
  end
end
