class UserreviewsController < ApplicationController
  before_action :set_userreview, only: [:show, :edit, :update, :destroy]

  # GET /userreviews
  # GET /userreviews.json
  def index
    @userreviews = Userreview.all
  end

  # GET /userreviews/1
  # GET /userreviews/1.json
  def show
  end

  # GET /userreviews/new
  def new
    @userreview = Userreview.new
  end

  # GET /userreviews/1/edit
  def edit
  end

  # POST /userreviews
  # POST /userreviews.json
  def create
    @userreview = Userreview.new(userreview_params)

    respond_to do |format|
      if @userreview.save
        format.html { redirect_to @userreview, notice: 'Userreview was successfully created.' }
        format.json { render :show, status: :created, location: @userreview }
      else
        format.html { render :new }
        format.json { render json: @userreview.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /userreviews/1
  # PATCH/PUT /userreviews/1.json
  def update
    respond_to do |format|
      if @userreview.update(userreview_params)
        format.html { redirect_to @userreview, notice: 'Userreview was successfully updated.' }
        format.json { render :show, status: :ok, location: @userreview }
      else
        format.html { render :edit }
        format.json { render json: @userreview.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /userreviews/1
  # DELETE /userreviews/1.json
  def destroy
    @userreview.destroy
    respond_to do |format|
      format.html { redirect_to userreviews_url, notice: 'Userreview was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_userreview
      @userreview = Userreview.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def userreview_params
      params.require(:userreview).permit(:name, :body, :userlogin_id)
    end
end
