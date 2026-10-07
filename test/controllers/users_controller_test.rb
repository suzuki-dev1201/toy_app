require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { email: @user.email, name: @user.name } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should show the first micropost belonging to the user" do
    first_micropost = @user.microposts.create!(content: "First user's post")
    @user.microposts.create!(content: "Second user's post")
    users(:two).microposts.create!(content: "Another user's post")

    get user_url(@user)

    assert_response :success
    assert_select "p", text: first_micropost.content
    assert_select "p", text: /Content:/, count: 0
    assert_select "p", text: /User:/, count: 0
    assert_select "body", text: /Second user's post/, count: 0
    assert_select "body", text: /Another user's post/, count: 0
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { email: @user.email, name: @user.name } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
