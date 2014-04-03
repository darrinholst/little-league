Pll::Application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root :to => 'home#index'
  resources :teams
  get 'calendar', :to => 'calendar#index', :as => 'calendar'
  get 'calendar/home', :to => 'calendar#home'
  get 'calendar/:team_id.ics', :to => 'calendar#ical', :as => 'team_ical'
end
