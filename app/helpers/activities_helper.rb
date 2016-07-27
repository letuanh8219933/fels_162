module ActivitiesHelper

  def create_activity user_id, target_id, activity_type
    Activity.create user_id: user_id, target_id: target_id,
      activity_type: activity_type
  end
end
