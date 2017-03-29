class UrlsController < ApplicationController
  before_action :set_url, only: [:show, :edit, :update, :destroy]
  before_action :add_page_number_size, only: [:index]

  # GET /urls
  # GET /urls.json
  def index
    @urls = Url.paginate(:page => params[:page].to_i, :per_page => params[:size])
    respond_to do |format|
      format.html
      format.json {render json: @urls}
    end
  end

  # GET /urls/1
  # GET /urls/1.json
  def show
    respond_to do |format|
      format.html
      format.json {render json: @url}
    end
    # render json: @url
  end

  # GET /urls/new
  def new
    @url = Url.new
  end

  # GET /urls/1/edit
  def edit
  end

  # POST /urls
  # POST /urls.json
  def create
    @url = Url.new(url_params)

    respond_to do |format|
      if @url.save
        format.html { redirect_to @url, notice: 'Url was successfully shortened.' }
        format.json { render json: @url, status: :created }
        # render json: short_url, status: :created
      else
        format.html { render :new }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urls/1
  # PATCH/PUT /urls/1.json
  def update
    respond_to do |format|
      if @url.update(url_params)
        format.html { redirect_to @url, notice: 'Url was successfully updated.' }
        format.json { render json: @url, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /urls/1
  # DELETE /urls/1.json
  def destroy
    @url.destroy
    respond_to do |format|
      format.html { redirect_to urls_url, notice: 'Url was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def out_url
    url = Url.find_by_shorty(params[:shorty])
    if url
      redirect_to url.original_url
    else
      render json: {errors: {message: "Couldn't find the data"}}, status: 204
    end
  end

  def api_page
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_url
      @url = Url.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def url_params
      params.require(:url).permit(:original_url)
    end
end
