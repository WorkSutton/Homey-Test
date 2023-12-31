Rails.application.routes.draw do
  root "projects#index"

  resources :projects, only: [:new, :create, :index, :show, :update] do
    resources :comments, only: [:new, :create, :show]
  end
end
