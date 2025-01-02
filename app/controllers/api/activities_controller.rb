module Api
  class ActivitiesController < ApplicationController
    def start
      existing_activity = Activity.where(user_id: user.id).where.not(start_at: nil).order(created_at: :desc).first
      if existing_activity.present?
        render json: {"error": "your existing sleeping activity is not finished yet"}, status: :unprocessable_entity
      else
        Activity.create(
          user: user,
          start_at: Time.current
        )
  
        render status: :created
      end
    end

    private

    def user
      @user ||= User.find(request.headers["x-user-id"])
    end
  end
end