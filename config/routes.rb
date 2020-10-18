Rails.application.routes.draw do
  get 'characters' => 'characters#index'
  root 'characters#index'
end
