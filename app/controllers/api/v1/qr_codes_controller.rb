class Api::V1::QrCodesController < ApplicationController



  # GET /qr_codes
  def index
    @qr_codes = QrCode.all
    render json: @qr_codes
  end

  # GET /qr_codes/1
  def show
    @qr_code = QrCode.find(params[:id])
    return render json: { message: "You do not have permission to update this QR Code" }, status: :unauthorized unless @qr_code.clerk_user_id == clerk_user['id']
    render json: @qr_code
  end

  # POST /qr_codes
  def create
    unless QrUsage.can_create_qr?(clerk_user['id'])
      return render json: { error: "You've reached the QR Code limit" }, status: :unauthorized
    end
  
    @qr_code = QrCode.new
    @qr_code.clerk_user_id = clerk_user['id']
  
    puts clerk_user[:id]
    @qr_code.title = params[:title]
    @qr_code.main_color = params[:main_color]
    @qr_code.target_url = params[:target_url]
    @qr_code.save
  
    if @qr_code.save
      #render json: @qr_code.qr_code_data, status: :created
      render json: @qr_code, status: :created
    else
      render json: @qr_code.errors, status: :unprocessable_entity
    end
  end

  def all_user_qr_codes
    @qr_codes = QrCode.where(clerk_user_id: clerk_user['id']).order(created_at: :desc)
    render json: @qr_codes.as_json(only: [:clerk_user_id, :title, :target_url,:qr_code_data,:created_at,:updated_at, :id])
  end

  def redirect
    random_server_url = request.original_url
    qr_code = QrCode.find_by(random_server_url: random_server_url)

    if qr_code
      redirect_to qr_code.target_url, allow_other_host: true
    else
      # handle case when there is no qr_code...
      render json: { error: "URL not found" }, status: 404
    end
  end

  # PATCH/PUT /qr_codes/1
  def update
    @qr_code = QrCode.find(params[:id])
    
    # Checking if the user is the owner of the qr_code
    return render json: { message: "You do not have permission to update this QR Code" }, status: :unauthorized unless @qr_code.clerk_user_id == clerk_user['id']
      
    if @qr_code.update(qr_code_params)
      render json: @qr_code, status: :ok
    else
      render json: { message: "Update failed", errors: @qr_code.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /qr_codes/1
  def destroy
    puts "provided ID"
    puts params[:id]
    @qr_code = QrCode.find(params[:id])

    # Checking if the user is the owner of the qr_code
    return render json: { message: "Something went wrong" } unless @qr_code.clerk_user_id == clerk_user['id']
    @qr_code.destroy
  end

  private
  
  def qr_code_params
    params.require(:qr_code).permit(:title, :target_url, :qr_code_data, :main_color, :id)
  end

  def authorize_request
    return render json: { message: "You are not authorized" }, status: :unauthorized unless clerk_session.present?
  end

  def check_usage(clerk_user_id)

  end
end
