class AdminController < ApplicationController
  before_action :check_admin, :only => [:index]
  def index
  end
end
