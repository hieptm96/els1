class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :lesson
  belongs_to :category

  def self.create_activity category_id, count, user_id
    Activity.create(category_id: category_id, word_learned_quantity: count, user_id: user_id)
  end
end
