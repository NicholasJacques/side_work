module RestaurantHelper
  def valid_restaurant_params
    { name: "Bertucci's",
      manager: 'Nicholas Jacques',
      phone_number: '207-829-0379',
      user_attributes: { email: 'test@test.com',
                         password: 'password123',
                         password_confirmation: 'password123' }
    }
  end

  def invalid_restaurant_params
    { name: "Bertucci's",
      manager: 'Nicholas Jacques',
      phone_number: '207-829-0379',
      user_attributes: { email: 'bad#email.com',
                         password: 'password123',
                         password_confirmation: 'password123' }
    }
  end
end