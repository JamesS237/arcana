class StaticPagesController < ApplicationController
  def home
    if view_context.current_user
      redirect_to results_path
    end
  end

  def about
  end

  def legal
  end

  def search
    @assessments = Assessment.search(params[:search], suggest: true)
  	@subjects = Subject.search(params[:search])
   	@students = Student.search(params[:search])
  end
end
