class AdminController < ApplicationController
  before_action :login_required, :only => [:index]
  before_action :check_admin, :only => [:index]
  def index
  end
end
