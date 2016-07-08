class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find_by(id: params[:id])
  end

  def new
    @lesson = Lesson.new
  end

  def create
    if Result.result_count(lesson_params[:category_id], lesson_params[:user_id]) ==
        Word.word_count(lesson_params[:category_id])
      flash[:danger] = t("lessons.error")
      redirect_to categories_path
    else
      @lesson = Lesson.new lesson_params
      if @lesson.save
        flash[:success] = t("lessons.success_create")
        redirect_to @lesson
      else
        flash[:danger] = t("lessons.failed_create")
        redirect_to categories_path
      end
    end
  end

  private
  def lesson_params
    params.require(:lesson).permit :category_id, :user_id
  end
end
