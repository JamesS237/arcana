class AssessmentsController < ApplicationController
  before_action :set_assessment, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, only: [:create, :new, :edit, :update, :destroy]
  before_action :logged_in

  def autocomplete
    render json: Assessment.search(params[:query], fields: [{title: :text_start}], limit: 10).map(&:title)
  end

  # GET /assessments
  # GET /assessments.json
  def index
    @assessments = $redis.get("queries:assessments:all")
  end

  # GET /assessments/1
  # GET /assessments/1.json
  def show
  end

  # GET /assessments/new
  def new
    @assessment = Assessment.new
  end

  # GET /assessments/1/edit
  def edit
  end

  # POST /assessments
  # POST /assessments.json
  def create
    @assessment = Assessment.new(assessment_params)

    respond_to do |format|
      if @assessment.save
        Thread.new { Assessment.cache(:all) }
        format.html { redirect_to assessments_path, notice: 'Assessment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @assessment }
      else
        format.html { render action: 'new' }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assessments/1
  # PATCH/PUT /assessments/1.json
  def update
    respond_to do |format|
      if @assessment.update(assessment_params)
        Thread.new { Assessment.cache(:all) }
        format.html { redirect_to assessments_path, notice: 'Assessment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assessments/1
  # DELETE /assessments/1.json
  def destroy
    @assessment.destroy
    Thread.new { Assessment.cache(:all) }
    respond_to do |format|
      format.html { redirect_to assessments_url }
      format.json { head :no_content }
    end
  end

  private
    def set_assessment
      @assessment = Assessment.find_by_title(params[:id].gsub('-', ' '))
    end

    def assessment_params
      params.require(:assessment).permit(:subject_id, :type_id, :title, :exam, :term)
    end

    def is_admin
      redirect_to root_path unless view_context.current_user.admin
    end

    def logged_in
      redirect_to root_path unless view_context.current_user
    end
end
