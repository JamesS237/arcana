class StaticPagesController < ApplicationController
  def home
    @student = Student.new
  end

  def about
  end
  
  def legal
  end
end
