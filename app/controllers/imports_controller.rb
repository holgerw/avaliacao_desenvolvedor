class ImportsController < ApplicationController

  # GET /imports/new
  def new
    @import = Import.new
  end

  # POST /imports
  def create
    @import = Import.new(import_params)
    if @import.save
      format.html { redirect_to @import, notice: 'Import was successfully created.' }
    else
      format.html { render :new }
    end
  end

  private
    def import_params
      params.require(:import).permit(:file)
    end
end
