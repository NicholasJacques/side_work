module ContractorHelper
  def valid_contractor_params
    { first_name: 'Nicholas',
      last_name:  'Jacques',
      email:      'test@test.com',
      password:   'password123' }
  end

  def invalid_contractor_params
    { first_name: 'Nicholas',
      last_name:  'Jacques',
      email:      '',
      password:   'password123' }
  end

  def sign_in_contractor(contractor)
    page.set_rack_session(user_id: contractor.id)
  end
end
