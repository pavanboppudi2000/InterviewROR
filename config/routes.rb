Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  root 'schedules#index'
  resources :interviewees
  resources :interviewers
  resources :schedules

  get 'fine/:id' => 'interviewees#findmail'
   
end
