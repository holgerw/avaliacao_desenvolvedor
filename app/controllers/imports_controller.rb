class ImportsController < ApplicationController

  # GET /imports/new
  def new
    @import = Import.new
    @import_history = Import.order(created_at: :desc)
  end

  # POST /imports
  def create
    save_path = persist_upload(params[:import][:file])
    @import = Import.new(saved_file: save_path)
    if @import.save
      @import.perform_import!
      redirect_to new_import_path, notice: 'Import was successfully created.'
    else
      render :new
    end
  end

  private
    def persist_upload( upload )
      save_path = Rails.root.join('uploads', "#{SecureRandom.uuid}.txt")
      File.open(save_path, 'wb') do |file|
        file.write(upload.read)
      end
      save_path
    end

end
