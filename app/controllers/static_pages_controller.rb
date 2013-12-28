class StaticPagesController < ApplicationController
  def home
  end

  def about
  end
  
  def legal
  end

  def search
  	@assessments = Assessment.search(params[:search])
  	@subjects = Subject.search(params[:search])
   	@students = Studentg.search(params[:search])
  end
end
