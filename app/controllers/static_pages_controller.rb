class StaticPagesController < ApplicationController
  def home
  end

  def about
  end
  
  def legal
  end

  def search
  	@assessments = Assessment.search(params[:q])
  	@subjects = Subject.search(params[:q])
   	@students = Student.search(params[:q])
  end
end
