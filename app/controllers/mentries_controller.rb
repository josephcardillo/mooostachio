class MentriesController < ApplicationController
  before_action :set_mentry, only: [:show, :edit, :update, :destroy]

  # GET /mentries
  # GET /mentries.json
  def index
      @mentries = Mentry.all
  end


  # GET /mentries/1
  # GET /mentries/1.json
  def show
    @mentries = Mentry.order("date DESC")

  end

  # GET /mentries/new
  def new
    @mentry = Mentry.new
    if current_user
      redirect_to root_path
    end
  end

  # GET /mentries/1/edit
  def edit
  end

  # POST /mentries
  # POST /mentries.json
  def create
    @mentry = Mentry.new(mentry_params)
    @mentry.user_id = current_user.id
    respond_to do |format|
      if @mentry.save && @mentry.mtype.name == 'Transfer'
        format.html { redirect_to new_mentry_path, notice: 'Entry was successfully created.' }
        format.json { render :edit, status: :created, location: @mentry }
        format.js
      elsif @mentry.save && @mentry.mtype != 'Transfer'
        format.html { redirect_to root_path, notice: 'Entry was successfully created.' }
        format.json { render :show, status: :created, location: @mentry }
        format.js
      else
        format.html { render :new }
        format.json { render json: @mentry.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /mentries/1
  # PATCH/PUT /mentries/1.json
  def update
    respond_to do |format|
      if @mentry.update(mentry_params)
        format.html { redirect_to @mentry, notice: 'Entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @mentry }
      else
        format.html { render :edit }
        format.json { render json: @mentry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentries/1
  # DELETE /mentries/1.json
  def destroy
    @mentry.destroy
    respond_to do |format|
      format.html { redirect_to mentries_url, notice: 'Entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mentry
      @mentry = Mentry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mentry_params
      params.require(:mentry).permit(:amount, :date, :note, :maccount_id, :mcategory_id, :mlocation_id, :mtype_id, :mstatus_id, :split, :entry_id)
    end
end
