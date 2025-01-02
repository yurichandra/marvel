module Api
  class UsersController < ApplicationController
    
    def follow
      user = User.find(follow_params[:user_id])

      if user_follow.present?
        render json: {"status": "ok"}
      elsif follow_yourself?(user.id)
        render json: {"error": "can't follow yourself"}, status: :bad_request
      else
        UserFollow.create(follower_id: follower_id, following_id: user.id)
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

    def follow_yourself?(user_id)
      user_id == follower_id
    end
  
    def follower_id
      @follower_id ||= User.find(request.headers["x-user-id"]).id
    end
  end
end