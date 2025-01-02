module Api
  class ActivitiesController < ApplicationController
    def my_activities
      activities = user.activities.order(created_at: :desc)
      render json: activities
    end

    def start
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

    def finish
      if existing_activity.nil?
        render json: {"error": "you don't have active sleeping activity yet"}, status: :unprocessable_entity
      else
        FinishActivityService.new(existing_activity).perform
        render json: {"status": "ok"}
      end
    end

    private

    def user
      @user ||= User.find(request.headers["x-user-id"])
    end

    def existing_activity
      @existing_activity ||= Activity.where(user_id: user.id).where.not(start_at: nil).where(end_at: nil).order(created_at: :desc).first
    end
  end
end