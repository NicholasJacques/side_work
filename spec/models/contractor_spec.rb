require 'rails_helper'

RSpec.describe Contractor, type: :model do
  it 'has a valid factory' do
    expect(build(:contractor)).to be_valid
  end

  let(:contractor) { build(:contractor) }
  
  describe 'attributes' do
    describe 'first_name' do
      it 'must exist' do
        contractor.first_name = nil
        expect(contractor).to_not be_valid 
      end

      it 'cannot be longer than 50 chars' do
        contractor.first_name = 'a' * 51
        expect(contractor).to_not be_valid               
      end
    end

    describe 'last_name' do
      it 'must exist' do
        contractor.last_name = nil
        expect(contractor).to_not be_valid 
      end

      it 'cannot be longer than 50 chars' do
        contractor.last_name = 'a' * 51
        expect(contractor).to_not be_valid     
      end
    end

    describe ':email' do
      it 'must exist' do
        contractor.email = nil
        expect(contractor).to_not be_valid
      end

      it 'accepts valid emails' do
        valid_emails.each do |email|
          contractor.email = email
          expect(contractor).to be_valid
        end
      end
      
      it 'rejects invalid emails' do
        invalid_emails.each do |email|
          contractor.email = email
          expect(contractor).to_not be_valid          
        end
      end

      it 'should be unique' do
        new_user = build(:contractor)
        new_user.email = contractor.email.upcase
        contractor.save
        expect(new_user).to_not be_valid
      end

      it 'should be stored lower-case' do
        mixed_case_email = 'TeSt@eXAMple.com'
        contractor.email = mixed_case_email
        contractor.save
        expect(contractor.email).to eq(mixed_case_email.downcase)
      end
    end

    describe 'password' do
      it 'must be present' do
        contractor.password = '  '
        expect(contractor).to_not be_valid
      end

      it 'must be longer than 6 chars' do
        contractor.password = 'tp123'
        expect(contractor).to_not be_valid        
      end

      it 'must be shorter than 50 characters' do
        contractor.password = 'test123' + 'a' * 44
        expect(contractor).to_not be_valid                
      end

      it 'must contain at least one number or symbol' do
        valid_passwords = %w[password1
                           p@ssword
                           pa5$word1
                           #*@&#*&
                           198324098402]

        valid_passwords.each do |password|
          contractor.password = password
          expect(contractor).to be_valid      
        end

        contractor.password = 'Password'
        expect(contractor).to_not be_valid
      end
    end
  end
end
