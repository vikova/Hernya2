module OurModule
  def register_user
    @driver.navigate.to 'http://demo.redmine.org'
    @driver.find_element(:class, 'register').click

    sleep 5
    login = ('login' + rand(9999).to_s)

    @driver.find_element(:id, 'user_login').send_keys login
    @driver.find_element(:id, 'user_password').send_keys 'adgj1234'
    @driver.find_element(:id, 'user_password_confirmation').send_keys 'adgj1234'
    @driver.find_element(:id, 'user_firstname').send_keys 'viktoriia'
    @driver.find_element(:id, 'user_lastname').send_keys 'kovalenko'
    @driver.find_element(:id, 'user_mail').send_keys (login + '@gmail.com')

    @driver.find_element(:name, 'commit').click
  end

  def log_in_me
    @driver.navigate.to 'http://demo.redmine.org'

    @driver.find_element(:class, 'login').click

    sleep 5

    @driver.find_element(:id, 'username').send_keys 'kovalenko.viktoriia'
    @driver.find_element(:id, 'password').send_keys 'adgj1234'

    sleep 2

    @driver.find_element(:name, 'login').click
    sleep 2

  end

  def create_project
    log_in_me

    @driver.find_element(:class, 'projects').click
    sleep 3
    @driver.find_element(:class, 'icon-add').click
    sleep 3

    name = ('new_name' + rand(9999).to_s)

    @driver.find_element(:id, 'project_name').send_keys name
    @driver.find_element(:name, 'commit').click
  end

end