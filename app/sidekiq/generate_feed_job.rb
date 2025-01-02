class GenerateFeedJob
  include Sidekiq::Job

  def perform(activity_id, user_id)
    client = Redis.new(url: ENV['REDIS_URL'])
    
    # Get latest activity
    activity = Activity.find(activity_id)

    # Get list of followers of a user
    follower_ids = UserFollow.where(following_id: user_id).pluck(:follower_id)

    # Generate feeds for each of the followers
    follower_ids.each do |follower_id|
      key = "feeds_#{follower_id}"
      feeds = client.get(key)

      if feeds.nil?
        new_activities = [activity].map do |a|
          {
            id: a.id,
            user_id: a.user_id,
            start_at: a.start_at,
            end_at: a.end_at,
            duration: a.duration,
            created_at: a.created_at,
            updated_at: a.updated_at
          }
        end
      else
        activities = JSON.parse(feeds).map { |attribute| Activity.new(attribute) }
        activities << activity
        sorted = activities.sort_by{ |a| -a.duration }

        new_activities = sorted.map do |a|
          {
            id: a.id,
            user_id: a.user_id,
            start_at: a.start_at,
            end_at: a.end_at,
            duration: a.duration,
            created_at: a.created_at,
            updated_at: a.updated_at
          }
        end
      end

      client.set(key, new_activities.to_json)
    end
  end
end
