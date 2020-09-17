Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'schedules#index'
  resources :interviewees
  resources :interviewers
  resources :schedules
end
