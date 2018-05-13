class DashboardController < ApplicationController
  def index
    @mentries = Mentry.all
    @mcategories = Mcategory.all
    @mcategory = @mcategories.find_by(params[:name])
    @maccounts = Maccount.all
    @mentry = Mentry.new
  end

  def show
    @maccounts = Maccount.all
    @mentry = Mentry.new(mentry_params)
    @mentry.user_id = current_user.id

      if @mentry.save && @mentry.mtype.name == 'Transfer'
        respond_to do |format|
          format.js
        end
      end
        # format.html { redirect_to new_mentry_path, notice: 'Mentry was successfully created.' }
        # format.json { render :edit, status: :created, location: @mentry }
      # elsif @mentry.save && @mentry.mtype != 'Transfer'
      #   format.html { redirect_to root_path, notice: 'Mentry was successfully created.' }
      #   format.json { render :show, status: :created, location: @mentry }
      # else
      #   format.html { render :new }
      #   format.json { render json: @mentry.errors, status: :unprocessable_entity }
      # end
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mentry
      @mentry = Mentry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mentry_params
      params.require(:mentry).permit(:amount, :date, :note, :maccount_id, :mcategory_id, :mlocation_id, :mtype_id, :mstatus_id)
    end
end
