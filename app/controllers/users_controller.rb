class UsersController < ApplicationController
  def follow
    user = User.find(follow_params[:user_id])

    if user_follow.present?
      render json: {"status": "ok"}
    else
      UserFollow.create(follower_id: follower_id, following_id: follow_params[:user_id])
      render json: {"status": "ok"}
    end
  end

  def unfollow
    if user_follow.nil?
      render json: {"error": "you are not follow the user"}, status: :bad_request
    else
      UserFollow.where(follower_id: follower_id, following_id: follow_params[:user_id]).delete_all
      render json: {"status": "ok"}
    end

  end

  private

  def user_follow
    UserFollow.find_by(follower_id: follower_id, following_id: follow_params[:user_id])
  end

  def follow_params
    params.permit(:user_id)
  end

  def follower_id
    request.headers["x-user-id"]
  end
end