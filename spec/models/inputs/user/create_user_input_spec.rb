# frozen_string_literal: true

RSpec.describe Inputs::User::CreateUserInput do
  describe "validations" do
    let(:input) { described_class.new(params) }

    describe "valid" do
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

      it "validation is success" do
        expect(input.valid?).to be_truthy
      end
    end

    describe "invalid" do
      context "email is null" do
        let(:params) do
          {
            email:       nil,
            password:    "password",
            first_name:  "Shohei",
            last_name:   "Ohtani",
            username:    "john_doe",
            postal_code: "123-4567",
            address:     "Tokyo, Japan",
            phone:       "03-1234-5678"
          }
        end

        it "validation is failed" do
          expect(input.valid?).to be_falsey
        end
      end

      context "email value is invalid format" do
        let(:params) do
          {
            email:       "invalid_email",
            password:    "password",
            first_name:  "Shohei",
            last_name:   "Ohtani",
            username:    "john_doe",
            postal_code: "123-4567",
            address:     "Tokyo, Japan",
            phone:       "03-1234-5678"
          }
        end

        it "validation is failed" do
          expect(input.valid?).to be_falsey
        end
      end
    end
  end
end
