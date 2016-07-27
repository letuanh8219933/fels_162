class Activity < ActiveRecord::Base
  belongs_to :user

  enum activity_type: [:start_lesson, :finish_lesson]

  def show
    if self.start_lesson?
      I18n.t "model.activity.show.start_lesson", name: self.user.name,
        id: self.target_id, created_at: self.created_at
    else self.finish_lesson?
      I18n.t "model.activity.show.finish_lesson", name: self.user.name,
        id: target_id, created_at: self.created_at
    end
  end
end
