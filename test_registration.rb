require 'test/unit'
require 'selenium-webdriver'
require_relative 'our_module'     #include our file .rb

class TestRegistration < Test::Unit::TestCase # our file
  include OurModule           # our file

  def setup
    @driver = Selenium::WebDriver.for :firefox

  end

  def test_positive
    register_user
    expected_test = 'Ваша учётная запись активирована. Вы можете войти.'
    actual_test = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_test, actual_test)
  end

  def test_log_out
    register_user
    @driver.find_element(:class, 'logout').click

    sleep 3

    login_button = @driver.find_element(:class, 'login')

    assert(login_button.displayed?)
  end

  def test_log_in
    log_in_me

    logout_button = @driver.find_element(:class, 'logout')

    assert(logout_button.displayed?)
  end

  def test_change_password
    register_user

    @driver.find_element(:class, 'my-account').click
    sleep 5
    @driver.find_element(:class, 'icon-passwd').click
    sleep 3
    @driver.find_element(:id, 'password').send_keys 'adgj1234'
    @driver.find_element(:id, 'new_password').send_keys 'adgj5678'
    @driver.find_element(:id, 'new_password_confirmation').send_keys 'adgj5678'
    @driver.find_element(:name, 'commit').click

    expected_test = 'Пароль успешно обновлён.'
    actual_test = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_test, actual_test)

  end

  def test_create_project
    create_project

    expected_test = 'Создание успешно.'
    actual_test = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_test, actual_test)

  end
  def test_add_user
    create_project
    @driver.find_element(:id, 'tab-members').click
    @driver.find_element(:class, 'icon-add').click
    sleep 2

    @driver.find_element(:id, 'principal_search').send_keys 'login'
    sleep 2
    @driver.find_element(:css, '[value="164911"]').click
    @driver.find_elements(css: 'input[value="5"]').each do |role|
      role.click if role.displayed?
    end

    @driver.find_element(:id, 'member-add-submit').click

  end

  def test_edit_their_roles
    create_project
    @driver.find_element(:id, 'tab-members').click
    @driver.find_element(:class, 'icon-add').click
    sleep 2

    @driver.find_element(:id, 'principal_search').send_keys 'login'
    sleep 2
    @driver.find_element(:css, '[value="164911"]').click
    @driver.find_elements(css: 'input[value="5"]').each do |role|
      role.click if role.displayed?


    end
    @driver.find_element(:id, 'member-add-submit').click
    sleep 5


    @driver.find_elements(css: ".member .buttons .icon-edit").first.click
    @driver.find_elements(css: 'input[value="3"]').each do |role|
      role.click if role.displayed?
    end
    @driver.find_elements(css: 'input[value="4"]').each do |role|
      role.click if role.displayed?
    end
    sleep 3
    @driver.find_element(:class, 'small').click

  end

  def test_project_version
    create_project

    @driver.find_element(:id, 'tab-versions').click
    sleep 2

    #@driver.find_element(:class, 'icon-add').click

    @driver.find_elements(css: '.icon-add').each do |versions|
      versions.click if versions.displayed?
    end
    sleep 5

   @driver.find_element(:name, 'version[name]').send_keys 'hfhfhh'

    @driver.find_element(:name, 'commit').click

    expected_test = 'Создание успешно.'
    actual_test = @driver.find_element(:id, 'flash_notice').text
    assert_equal(expected_test, actual_test)

  end

  def test_create_issues
    create_project
    @driver.find_element(:class, 'new-issue').click
    sleep 3

    @driver.find_element(:id, 'issue_tracker_id').click
    @driver.find_elements(css: '#issue_tracker_id option[value="1"]').each do |option|
      option.click if option.displayed?

    end
    sleep 3
    @driver.find_element(:id, 'issue_subject').send_keys 'new'

    @driver.find_element(:name, 'commit').click

    @driver.find_element(:class, 'new-issue').click
    sleep 3

    @driver.find_element(:id, 'issue_tracker_id').click
    @driver.find_elements(css: '#issue_tracker_id option[value="2"]').each do |option|
      option.click if option.displayed?

    end
    sleep 3
    @driver.find_element(:id, 'issue_subject').send_keys 'new'

    @driver.find_element(:name, 'commit').click

    @driver.find_element(:class, 'new-issue').click
    sleep 3

    @driver.find_element(:id, 'issue_tracker_id').click
    @driver.find_elements(css: '#issue_tracker_id option[value="3"]').each do |option|
      option.click if option.displayed?

    end
    sleep 3
    @driver.find_element(:id, 'issue_subject').send_keys 'new'

    @driver.find_element(:name, 'commit').click


    flash_notice = @driver.find_element(:id, 'flash_notice')

    assert(flash_notice.displayed?)

  end

  def teardown         # close browser
    @driver.quit
  end
end