require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe 'associations' do
    describe 'profile' do
      it 'can be an instance of Contractor' do
        expect(user.profile).to be_a(Contractor)
      end
    end
  end

  describe 'attributes' do
    describe 'email' do
      it 'must exist' do
        user.email = nil
        expect(user).to_not be_valid
      end

      it 'accepts valid emails' do
        valid_emails.each do |email|
          user.email = email
          expect(user).to be_valid
        end
      end

      it 'rejects invalid emails' do
        invalid_emails.each do |email|
          user.email = email
          expect(user).to_not be_valid
        end
      end

      it 'should be unique' do
        new_user = build(:user)
        new_user.email = user.email.upcase
        user.save
        expect(new_user).to_not be_valid
      end

      it 'should be stored lower-case' do
        mixed_case_email = 'TeSt@eXAMple.com'
        user.email = mixed_case_email
        user.save
        expect(user.email).to eq(mixed_case_email.downcase)
      end
    end

    describe 'password' do
      it 'must be present' do
        user.password = '  '
        expect(user).to_not be_valid
      end

      it 'must be longer than 6 chars' do
        user.password = 'tp123'
        expect(user).to_not be_valid        
      end

      it 'must be shorter than 50 characters' do
        user.password = 'test123' + 'a' * 44
        expect(user).to_not be_valid                
      end

      it 'must contain at least one number or symbol' do
        valid_passwords = %w[password1
                           p@ssword
                           pa5$word1
                           #*@&#*&
                           198324098402]

        valid_passwords.each do |password|
          user.password = password
          expect(user).to be_valid
        end

        user.password = 'Password'
        expect(user).to_not be_valid
      end
    end

    describe 'phone_number' do
      xit 'must be present' do
        user.phone_number = nil
        expect(user).to_not be_valid
      end
    end
  end
end
