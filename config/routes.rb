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
    resources :tags, only: [:index, :destroy] do
      get :autocomplete, on: :collection
    end
    resources :tasks, only: [:index, :destroy] do
      get :autocomplete, on: :collection
    end
    resources :project_tags, only: [:create, :destroy], concerns: :positionable
    resources :project_tasks, only: [:create, :destroy], concerns: :positionable
    resources :contacts, only: [:index, :show, :destroy]

    root to: "contacts#index"
  end

   # Front ==========================================
  resources :projects, only: [:index,:show], path: "projects"

  # resources :contacts, only: [:new, :create, :index]
  resources :contacts, path: 'contact',
    path_names: {new: ''},
    only: [:new, :create]


  get "/:filename", to: "statics#show"

  root to: "home#index"

end
