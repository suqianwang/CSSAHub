class AccountsController < ApplicationController
  before_action :login_required, :only => [:index, :show, :edit]
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    if (session['login'] == "admin")
      @accounts = Account.where(:archived => false)
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

  # GET /accounts/1
  # GET /accounts/1.json
  def show
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
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  # def update
    # respond_to do |format|
      # if @account.update(account_params)
        # format.html { redirect_to @account, notice: 'account was successfully updated.' }
        # format.json { render :show, status: :ok, location: @account }
      # else
        # format.html { render :edit }
        # format.json { render json: @account.errors, status: :unprocessable_entity }
      # end
    # end
  # end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
	@account.reason = params[:reason]
	puts "Raw reason"
	puts params[:reason]
    # @account.destroy
	@account.toggle!(:archived)
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
	puts "Reason:"
	puts (@account.reason)
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
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:username, :email, :name, :password, :password_confirmation, :terms_and_conditions)
    end
end
