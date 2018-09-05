module Requests
  module JsonHelpers
    def json_response
      JSON.parse(response.body)
    end
  end

  module Authentication
    def login(user, opts = {})
      visit('users/sign_in')
      fill_in('user_email', with: user.email)
      fill_in('user_password', with: opts[:password] || user.password)
      click_button("Log in")
    end
  end
end