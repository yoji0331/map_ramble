class InitialsController < ApplicationController
  before_action :set_initial, only: [:show, :edit, :update, :destroy]

  # GET /initials
  # GET /initials.json
  def index
    @initials = Initial.all
  end

  # GET /initials/1
  # GET /initials/1.json
  def show
  end

  # GET /initials/new
  def new
    @initial = Initial.new
  end

  # GET /initials/1/edit
  def edit
  end

  # POST /initials
  # POST /initials.json
  def create
    @initial = Initial.new(initial_params)

    respond_to do |format|
      if @initial.save
        format.html { redirect_to @initial, notice: 'Initial was successfully created.' }
        format.json { render action: 'show', status: :created, location: @initial }
      else
        format.html { render action: 'new' }
        format.json { render json: @initial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /initials/1
  # PATCH/PUT /initials/1.json
  def update
    respond_to do |format|
      if @initial.update(initial_params)
        format.html { redirect_to @initial, notice: 'Initial was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @initial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /initials/1
  # DELETE /initials/1.json
  def destroy
    @initial.destroy
    respond_to do |format|
      format.html { redirect_to initials_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_initial
      @initial = Initial.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def initial_params
      params.require(:initial).permit(:lat, :lng, :zoom)
    end
end
