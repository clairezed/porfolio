Rails.application.routes.draw do

  devise_for :admin

  namespace :admin do
    root :to => "dashboard#index"
  end

  get "/:filename", to: "statics#show"

  root :to => "home#index"

end
