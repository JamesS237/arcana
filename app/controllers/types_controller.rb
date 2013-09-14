class TypesController < ApplicationController
  before_action :set_type, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :logged_in

  # GET /types
  # GET /types.json
  def index
    @types = Type.all
  end

  # GET /types/1
  # GET /types/1.json
  def show
  end

  # GET /types/new
  def new
    @type = Type.new
  end

  # GET /types/1/edit
  def edit
  end

  # POST /types
  # POST /types.json
  def create
    @type = Type.new(type_params)

    respond_to do |format|
      if @type.save
        format.html { redirect_to types_path, notice: 'Type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @type }
      else
        format.html { render action: 'new' }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /types/1
  # PATCH/PUT /types/1.json
  def update
    respond_to do |format|
      if @type.update(type_params)
        format.html { redirect_to types_path, notice: 'Type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /types/1
  # DELETE /types/1.json
  def destroy
    @type.destroy
    respond_to do |format|
      format.html { redirect_to types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_type
      @type = Type.find_by_name(params[:id].gsub('-', ' '))
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def type_params
      params.require(:type).permit(:name, :weight)
    end
    
    def is_admin
      redirect_to root_path unless view_context.current_user.admin
    end
    
    def logged_in
      redirect_to root_path unless view_context.current_user
    end
end
