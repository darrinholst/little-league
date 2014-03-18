Pll::Application.routes.draw do
  devise_for :users

  root :to => 'calendar#index'

  resources :teams

  namespace :admin do
    match '', :to => 'home#index'
    resources :divisions
    resources :teams
    resources :players
    resources :coaches
    resources :fields
    resources :games

    match 'team-selection', :to => 'teams#selection'
    match 'division-selection', :to => 'divisions#selection'
  end


  get 'calendar', :to => 'calendar#index', :as => 'calendar'
  get 'calendar/home', :to => 'calendar#home'
  get 'calendar/:team_id.ics', :to => 'calendar#ical', :as => 'team_ical'
end
