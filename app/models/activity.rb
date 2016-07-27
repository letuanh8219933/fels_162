class Activity < ActiveRecord::Base
  belongs_to :user

  enum action_type: [:followed, :unfollowed, :start_lesson, :finish_lesson]

  def show
    if self.followed?
      user = User.find_by id: self.target_id
      I18n.t"model.activity.show.followed", follower: self.user.name,
        followed: user.name, created_at: self.created_at
    elsif self.unfollowed?
      user = User.find_by id: self.target_id
      I18n.t "model.activity.show.unfollowed", follower: self.user.name,
        followed: user.name, created_at: self.created_at
    elsif self.start_lesson?
      I18n.t "model.activity.show.start_lesson", name: self.user.name,
        id: self.target_id, created_at: self.created_at
    else self.finish_lesson?
      I18n.t "model.activity.show.finish_lesson", name: self.user.name,
        id: target_id, created_at: self.created_at
    end
  end
end
