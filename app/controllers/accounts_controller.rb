class AccountsController < ApplicationController
  before_action :login_required, :only => [:index, :show, :edit, :destroy, :update]
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    if (current_user.isAdmin == true)
      @accounts = Account.where(:archived => false).where(isAdmin: false)
	else
      redirect_to services_path, notice: "Logged in!"
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def archive
    if (current_user.isAdmin == true)
      @accounts = Account.where(:archived => true)
	else
      redirect_to services_path, notice: "Logged in!"
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    @profile = Account.find(params[:id])
	  if @profile.update_attributes!(update_params)
	    if @profile.save
        redirect_to profile_index_path, notice: "Account was successfully saved."
      end
    else
      flash[:alert] = "Account failed to save"
      redirect_to profile_index_path
    end
  end
  

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
	@account.reason = params[:account][:reason]
	@account.toggle!(:archived)
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully archived.' }
      format.json { head :no_content }
    end
  end
  
  def restore
	@account = Account.find(params[:id])
    @account.toggle!(:archived)
    respond_to do |format|
      format.html { redirect_to archive_accounts_url, notice: 'Account was successfully restored.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
	  # I made changes to this so if something broke, check here first
	  if params[:id] != nil
        @account = Account.find(params[:id])
	  elsif params[:account] != nil
	    @account = Account.find(params[:account][:id])
	  end
	  rescue ActiveRecord::RecordNotFound
        redirect_to "/home/index"
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:username, :email, :name)
    end
	
	def update_params
      params.permit(:name)
    end
end
