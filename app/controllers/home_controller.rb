class HomeController < ApplicationController

  skip_before_filter :remove_session

  def index
  end

end