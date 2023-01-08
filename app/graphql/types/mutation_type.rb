module Types
  class MutationType < Types::BaseObject
    field :create_user, Types::UserType, null: false do
      argument :email, String, required: true
      argument :password, String, required: true
      argument :first_name, String, required: true
      argument :last_name, String, required: true
      argument :username, String, required: true
      argument :postal_code, String, required: false
      argument :address, String, required: false
      argument :phone, String, required: false
    end
    def create_user(email:, password:, first_name:, last_name:, username:, postal_code: nil, address: nil, phone: nil)
      User.create!(
        email: email,
        password: password,
        first_name: first_name,
        last_name: last_name,
        username: username,
        postal_code: postal_code,
        address: address,
        phone: phone
      )
    end
  end
end
