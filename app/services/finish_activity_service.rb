class FinishActivityService
  def initialize(activity)
    @activity = activity
  end

  def perform
    finish_activity!
  end
  
  private

  def finish_activity!
    end_at = Time.current
    duration = Time.current - @activity.start_at
    @activity.update(end_at: end_at, duration: duration.to_int)
  end
end