class Lesson < ActiveRecord::Base
  belongs_to :category
  has_many :activities

  after_create :update_lesson

  def update_lesson
    @category = Category.find_by(id: self.category_id)
    @words = @category.words.where("words.id not in (select word_id from results where user_id = ?)",
      self.user_id).order("RAND()").limit(Settings.number_word_per_lesson)
    @words.each do |word|
      Result.create_result(self.user_id, self.category_id, self.id, word.id)
    end
    if @words.count > 0
      Activity.create_activity(self.category_id, @words.count, self.user_id)
    end
  end
end
