class Relationship < ActiveRecord::Base
  include ActivitiesHelper

  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name

  validates :follower, presence: true
  validates :followed, presence: true

  after_create :create_activity_follow
  after_create :create_activity_unfollow

  private
  def create_activity_follow
    create_activity self.follower_id, self.followed.id, :followed
  end

  def create_activity_unfollow
    create_activity self.follower_id, self.followed.id, :unfollowed
  end
end
