class HomeController < ApplicationController

  skip_before_filter :remove_session

  def index
    @projects = Project.homepage.order(:position).limit(3)
    @contact = Contact.new
  end

end