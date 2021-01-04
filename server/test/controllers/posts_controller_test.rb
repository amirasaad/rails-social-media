require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:morty)
    @morty_post = posts(:morty_post)
    @rick_post = posts(:rick_post)
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
      post :create, post: { body: 'New Post' }
    end

    assert_redirected_to posts_path
  end

  test "should show post" do
    get :show, id: @rick_post
    assert_response :success
  end

  test "morty should update their post" do
    patch :update, id: @morty_post, post: { body: 'New content' }
    assert_equal 'New content', Post.find(@morty_post.id).body
    assert_response :redirect
  end

  test "morty should not update rick post" do

    patch :update, id: posts(:rick_post), post: {body: 'Yo son of a bi**'}

    assert_equal @rick_post.body, Post.find(@rick_post.id).body

    assert_response :redirect
  end

  test "morty should destroy their post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: @morty_post.id
    end

    assert_response :redirect
  end
end
