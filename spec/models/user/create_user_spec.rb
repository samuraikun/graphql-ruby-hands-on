# frozen_string_literal: true

RSpec.describe User::CreateUser do
  describe "#call" do
    let(:params) do
      {
        email:       "test@example.com",
        password:    "password",
        first_name:  "Shohei",
        last_name:   "Ohtani",
        username:    "john_doe",
        postal_code: "123-4567",
        address:     "Tokyo, Japan",
        phone:       "03-1234-5678"
      }
    end

    it "create user" do
      input = Inputs::User::CreateUserInput.new(params)
      expect { described_class.new.call(input) }.to change(User, :count).by(1)
    end

    context "invalid input" do
      it "raise InputInvalid" do
        input = Inputs::User::CreateUserInput.new({})
        expect { described_class.new.call(input) }.to raise_error Inputs::InputInvalid
      end
    end
  end
end
