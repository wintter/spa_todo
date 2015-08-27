def set_omniauth()
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:facebook] = {
      'info' => {
          'name' => Faker::Name.name,
          'email' => Faker::Internet.email,
          'image' => '', },
      'uid' => '123545',
      'provider' => 'facebook',
      'credentials' => {'token' => 'token'}
  }
end