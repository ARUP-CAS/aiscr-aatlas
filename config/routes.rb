Rails.application.routes.draw do

  scope "/:locale", locale: /cs|en/ do

    resources :places, only: [:index, :show], path: 'lokace' do
      get :markers, on: :collection
    end

    get '/zdroje', to: 'home#sources', as: :sources
    get '/ke-stazeni', to: 'home#downloads', as: :downloads
    get '/o-projektu', to: 'home#about', as: :about
    get '/search', to: 'search#index', as: :search

    match '/404', to: 'errors#page404', via: :all
    match '/422', to: 'errors#page422', via: :all
    match '/500', to: 'errors#page500', via: :all

    # rescources :home
    get '/', to: "home#index"
  end

  resources :qr, only: [:show]

  root 'home#index'

  devise_for :users

  namespace :admin do
    root 'dashboard#index'
    get '/' => 'dashboard#index', as: :user_root_path

    resource :upload, only: [:show]

    # has to be below 'devise_for :users'
    resources :users
    resources :places
    resources :tags
    resources :media_items
    resources :media_placements, except: [:create, :edit,:new] do
      post 'insert_at', on: :member
    end
  end
end
