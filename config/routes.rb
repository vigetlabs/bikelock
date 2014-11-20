Bikelock::Application.routes.draw do
  mount Lockup::Engine => '/lockup'

  match 'twilio/process_sms' => 'twilio#process_sms', via: [:get, :post]

  root 'utility#index'

  get "lock"   => "utility#lock"
  get "unlock" => "utility#unlock"
end
