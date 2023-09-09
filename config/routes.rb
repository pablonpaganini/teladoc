Rails.application.routes.draw do
  get 'doctors', to: 'doctors#index'
  get 'doctors/:id/availability', to: 'doctors#available_time'
  
  post 'appointments', to: "appoinments#create"
  delete 'appointment/:id', to: "appoinments#delete"
  put 'appointment/:id', to: "appoinments#update"
end
