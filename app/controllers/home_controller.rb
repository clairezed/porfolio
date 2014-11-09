class HomeController < ApplicationController

  skip_before_filter :remove_session

  def index
    @projects = Project.homepage.order(:position)
  end

end