Rails.application.routes.draw do
  root to: 'patients#new'

  post '/patients', to: 'patients#create'

end
