class FileListsController < ApplicationController
  before_action :set_file_list, only: [:show, :edit, :update, :destroy]

  # GET /file_lists
  # GET /file_lists.json
  def index
    @disk = params[:disk]
    if (@disk == "")
      @disk = "All"
    end
    @filename = params[:filename]
    filename = @filename.to_s.gsub(/ANY/, "%")
    @page_number = 0
    if (params[:page_number].present?)
      @page_number = params[:page_number].to_i
    end
    @records_per_page = 25
    if (params[:records_per_page].present?)
      @records_per_page = params[:records_per_page].to_i
    end
    if (params[:disk].present?)
      if (@disk == "All")
        if (params[:filename].start_with?('^'))
          @file_lists = FileList.starts_with_all_disks(filename.gsub(/^./, "")).offset(@page_number * @records_per_page).limit(@records_per_page)
        else
          if (params[:filename].end_with?('$'))
            @file_lists = FileList.ends_with_all_disks(filename.gsub(/.$/, "")).offset(@page_number * @records_per_page).limit(@records_per_page)
          else
            @file_lists = FileList.contains_all_disks(filename).offset(@page_number * @records_per_page).limit(@records_per_page)
          end
        end
      else
        if (params[:filename].start_with?('^'))
          @file_lists = FileList.starts_with(filename.gsub(/^./, ""), @disk).offset(@page_number * @records_per_page).limit(@records_per_page)
        else
          if (params[:filename].end_with?('$'))
            @file_lists = FileList.ends_with(filename.gsub(/.$/, ""), @disk).offset(@page_number * @records_per_page).limit(@records_per_page)
          else
            @file_lists = FileList.contains(filename, @disk).offset(@page_number * @records_per_page).limit(@records_per_page)
          end
        end
      end
    else
      @file_lists = FileList.all.offset(@page_number * @records_per_page).limit(@records_per_page)
    end
  end

  # GET /file_lists/1
  # GET /file_lists/1.json
  def show
  end

  # GET /file_lists/new
  def new
    @file_list = FileList.new
  end

  # GET /file_lists/1/edit
  def edit
  end

  # POST /file_lists
  # POST /file_lists.json
  def create
    @file_list = FileList.new(file_list_params)

    respond_to do |format|
      if @file_list.save
        format.html { redirect_to @file_list, notice: 'File list was successfully created.' }
        format.json { render :show, status: :created, location: @file_list }
      else
        format.html { render :new }
        format.json { render json: @file_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /file_lists/1
  # PATCH/PUT /file_lists/1.json
  def update
    respond_to do |format|
      if @file_list.update(file_list_params)
        format.html { redirect_to @file_list, notice: 'File list was successfully updated.' }
        format.json { render :show, status: :ok, location: @file_list }
      else
        format.html { render :edit }
        format.json { render json: @file_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /file_lists/1
  # DELETE /file_lists/1.json
  def destroy
    @file_list.destroy
    respond_to do |format|
      format.html { redirect_to file_lists_url, notice: 'File list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_list
      @file_list = FileList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def file_list_params
      params.require(:file_list).permit(:disk, :filename)
    end
end
