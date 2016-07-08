class Result < ActiveRecord::Base
  belongs_to :user
  belongs_to :word
  belongs_to :lesson
  belongs_to :category

  scope :result_count, ->(category_id, current_user_id){where("category_id = ? and user_id = ?",
    category_id,current_user_id).count}

  def self.create_result user_id, category_id, lesson_id, word_id
    Result.create(user_id: user_id, category_id: category_id, lesson_id: lesson_id, word_id: word_id)
  end
end
