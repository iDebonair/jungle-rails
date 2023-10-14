require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid when password and password_confirmation matches' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to be_valid
    end

    it 'is not valid when password and password_confirmation do not match' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'wrong'
      )
      expect(user).not_to be_valid
    end

    it 'requires password and password_confirmation when creating the model' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: nil,
        password_confirmation: nil
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password can't be blank")

    end

    it 'validates email uniqueness (case-insensitive)' do
      User.create(        
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
    
      user = User.new(
        first_name: 'Jake',
        last_name: 'Doe',
        email: 'TEST@TEST.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Email has already been taken")
    end

    it 'requires email, first name, and last name when creating the model' do
      user = User.new(email: 'test@example.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("First name can't be blank")
      expect(user.errors.full_messages).to include("Last name can't be blank")

      user.first_name = 'John'
      user.last_name = 'Doe'
      expect(user).to be_valid
    end

    it 'validates password length' do
      user = User.new(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@example.com',
        password: '123', # Password is shorter than the minimum length
        password_confirmation: '123'
      )
      expect(user).not_to be_valid
      expect(user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
  
  describe 'authenticate valid credentials' do
    it 'returns the user' do
      user = User.new( 
      first_name: 'John',
      last_name: 'Doe',
      email: 'test@test.com', 
      password: 'password')
      user.save
      logged_user = User.authenticate_with_credentials(' test@TEST.com  ', 'password')
      expect(logged_user).to_not eq(nil)
      logged_user_nil = User.authenticate_with_credentials('test@test.com','123')
      expect(logged_user_nil).to eq(nil)
    end
  end
end
