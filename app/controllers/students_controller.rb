class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, only: :destroy
  before_action :correct_user, only: [:edit, :update]
  before_action :logged_in, only: [:show, :edit, :update, :destroy, :index]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @overall_average = view_context.current_user.averages.where(:overall => true).take
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    @student.password_confirmation = @student.password
    @student.first_name = @student.first_name.strip unless @student.first_name == nil 
    @student.last_name = @student.last_name.strip unless @student.last_name == nil 
    respond_to do |format|
      if @student.save
        view_context.sign_in @student
        format.html { redirect_to results_path, notice: 'Student was successfully created.' }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'new_error' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to results_path, notice: 'Student was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find_by_last_name(params[:id].split('-'))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:house, :full_name, :email, :password)
    end
    
    def is_admin
      redirect_to root_path unless view_context.current_user.admin
    end
    
    def logged_in
      redirect_to root_path unless view_context.current_user
    end
    
    def correct_user
      redirect_to root_path unless view_context.current_user.id = @student.id
    end
end
