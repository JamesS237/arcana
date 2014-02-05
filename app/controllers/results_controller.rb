class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :destroy]
  before_action :logged_in

  # GET /results
  # GET /results.json
  def index
    @results = $redis.get("queries:results:all")
  end

  # GET /results/1
  # GET /results/1.json
  def show
  end

  def user
    @results = Result.find_all_by_student_id(Student.find_by_last_name(params[:name].split('-')[1]).id)
    render 'index'
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    @result = Result.new()
    @result.student_id = view_context.current_user.id
    @result.assessment_id = params[:assessment][:id]
    @result.mark = params[:mark]
    @result.set_term!
    respond_to do |format|
      if @result.save
        Result.cache(:all)
        format.html { redirect_to results_path, notice: 'Result was successfully created.' }
        format.json { render action: 'show', status: :created, location: @result }
      else
        format.html { render action: 'new' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      @result = Result.find(params[:result][:id])
      @result.set_term!
      if @result.update(result_params)
        Result.cache(:all)
        format.html { redirect_to results_path, notice: 'Result was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    Result.cache(:all)
    respond_to do |format|
      format.html { redirect_to results_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def result_params
      params.require(:result).permit(:assessment_id, :mark)
    end

    def is_admin
      redirect_to root_path unless view_context.current_user.admin
    end

    def logged_in
      redirect_to root_path unless view_context.current_user
    end
end
