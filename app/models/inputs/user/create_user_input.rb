# frozen_string_literal: true

class Inputs::User::CreateUserInput
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :email, :string
  attribute :password, :string
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :username, :string
  attribute :postal_code, :string
  attribute :address, :string
  attribute :phone, :string

  validates :email, :password, :first_name, :last_name, :username, presence: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "is invalid e-mail address."
end
