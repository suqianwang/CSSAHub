class ServicesController < ApplicationController
  before_action :login_required, :only => [:index]
  def index
  end
end