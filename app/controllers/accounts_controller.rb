class AccountsController < ApplicationController
  before_action :login_required, :only => [:index, :show, :edit, :destroy, :update]
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    if (session['login'] == "admin")
      @accounts = Account.where(:archived => false).where.not(username: "admin")
	else
      redirect_to services_path, notice: "Logged in!"
    end
  end
  
  def archive
    if (session['login'] == "admin")
      @accounts = Account.where(:archived => true)
	else
      redirect_to services_path, notice: "Logged in!"
    end
  end

  # GET /accounts/new
  def new
    if current_user.blank?
      @account = Account.new
    else
      redirect_to services_path
    end
  end

  # GET /accounts/1/edit
  #def edit
  #end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    respond_to do |format|
      if @account.save
        format.html { redirect_to login_index_path, notice: 'Account was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
   def update
       @profile = Account.find(params[:id])
       if @profile.update_attributes!(update_params)
	     @profile.save
         redirect_to profile_index_path, notice: "Account was successfully saved"
       else
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
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:username, :email, :name, :password, :password_confirmation, :terms_and_conditions)
    end
	
	def update_params
      params.permit(:name, :password, :password_confirmation)
    end
end
