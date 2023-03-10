# frozen_string_literal: true

class User::CreateUser
  def call(input)
    raise Inputs::InputInvalid, input if input.invalid?

    User.create!(
      email:       input.email,
      password:    input.password,
      first_name:  input.first_name,
      last_name:   input.last_name,
      username:    input.username,
      postal_code: input.postal_code,
      address:     input.address,
      phone:       input.phone
    )
  end
end
