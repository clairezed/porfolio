Rails.application.routes.draw do

  # Concerns =======================================

  concern :positionable do
    patch :position, on: :member
  end

  # Admin ==========================================

  devise_for :admin

  namespace :admin do
    resources :projects, except: [:show], concerns: :positionable do
      get :get_picture_form, on: :collection
      patch :sort_picture, on: :member
      put :toggle_visible, on: :member
      put :toggle_highlighted, on: :member
    end


    root to: "dashboard#index"
  end

   # Front ==========================================
  resources :projects, only: [:index,:show], path: "projects"

  # resources :contacts, only: [:new, :create, :index], path_names: {new: 'formulaire'}



  get "/:filename", to: "statics#show"

  root to: "home#index"

end
