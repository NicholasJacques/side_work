module EmailHelper
  def valid_emails
    %w[email@example.com
       firstname.lastname@example.com
       email@subdomain.example.com
       firstname+lastname@example.com
       1234567890@example.com
       email@example-one.com
       _______@example.com
       email@example.name
       email@example.museum
       email@example.co.jp
       firstname-lastname@example.com]
  end

  def invalid_emails
    ['plainaddress',
     '#@%^%#$@#$@#.com',
     '@example.com',
     'Joe Smith <email@example.com>',
     'email.example.com',
     'email@example@example.com',
     '.email@example.com',
     'email.@example.com',
     'email..email@example.com',
     'あいうえお@example.com',
     'email@example.com (Joe Smith)',
     'email@example',
     'email@-example.com',
     'email@example..com',
     'Abc..123@example.com']
  end
end
