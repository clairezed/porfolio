class HomeController < ApplicationController

  skip_before_filter :remove_session

  def index
    @projects = Project.order(:created_at)
    # raise @projects.inspect
  end

end