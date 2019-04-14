class ServicesController < ApplicationController
  before_action :login_required, :only => [:index]
  def index
     if current_user.isAdmin == true
	   redirect_to admin_index_path
	 end
  end
end