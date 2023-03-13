require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it 'requires a password and password_confirmation to be created' do
      user = User.new(password: nil, password_confirmation: nil)
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include("can't be blank")
      expect(user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'requires password_confirmation to match password' do
      user = User.new(password: 'password', password_confirmation: 'different_password')
      expect(user).to_not be_valid
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'requires email, first name, and last name to be present' do
      user = User.new(email: nil, first_name: nil, last_name: nil)
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include("can't be blank")
      expect(user.errors[:first_name]).to include("can't be blank")
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    it 'requires emails to be unique (case-insensitive)' do
      User.create(email: 'test@test.com', first_name: 'John', last_name: 'Doe', password: 'password', password_confirmation: 'password')
      user = User.new(email: 'TEST@TEST.com', first_name: 'Jane', last_name: 'Doe', password: 'password', password_confirmation: 'password')
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include('has already been taken')
    end

    it 'requires a password to have a minimum length' do
      user = User.new(password: 'abc', password_confirmation: 'abc', email: 'test@example.com', first_name: 'John', last_name: 'Doe')
      expect(user).to_not be_valid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')

      user = User.new(password: 'abcdef', password_confirmation: 'abcdef', email: 'test@example.com', first_name: 'John', last_name: 'Doe')
      expect(user).to be_valid
    end
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        first_name: 'John',
        last_name: 'Doe',
        email: 'test@test.com',
        password: 'password',
        password_confirmation: 'password'
      )
    end

    context 'with valid credentials' do
      it 'returns an instance of the user' do
        user = User.authenticate_with_credentials('test@test.com', 'password')
        expect(user).to eq(@user)
      end
    end

    context 'with invalid email' do
      it 'returns nil' do
        user = User.authenticate_with_credentials('invalid@test.com', 'password')
        expect(user).to be_nil
      end
    end

    context 'with invalid password' do
      it 'returns nil' do
        user = User.authenticate_with_credentials('test@test.com', 'invalid')
        expect(user).to be_nil
      end
    end

    context 'with email containing leading/trailing spaces' do
      it 'returns an instance of the user' do
        user = User.authenticate_with_credentials('   test@test.com   ', 'password')
        expect(user).to eq(@user)
      end
    end

    context 'with email in different case' do
      it 'returns an instance of the user' do
        user = User.authenticate_with_credentials('TeSt@tEsT.cOm', 'password')
        expect(user).to eq(@user)
      end
    end   
  end
end