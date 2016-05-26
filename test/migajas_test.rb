class App
  include Migajas

  attr_reader :env

  def initialize
    @env = {}
    @env["SCRIPT_NAME"] = ""
    @env["PATH_INFO"] = ""
  end
end

setup do
  App.new
end

test "build up the array" do |app|
  app.env["SCRIPT_NAME"] = "/"
  app.breadcrumbs << "Home"

  app.env["SCRIPT_NAME"] = "/users"
  app.breadcrumbs << "Users"

  app.env["SCRIPT_NAME"] = "/users/5"
  app.breadcrumbs << "Jane Doe"

  assert_equal 3, app.breadcrumbs.size
  assert_equal ["/", "/users", "/users/5"], app.breadcrumbs.map(&:url)
  assert_equal ["Home", "Users", "Jane Doe"], app.breadcrumbs.map(&:name)
end

test "override URL" do |app|
  app.env["SCRIPT_NAME"] = "/"
  app.breadcrumbs << "Home"

  app.env["SCRIPT_NAME"] = "/users"
  app.breadcrumbs << "Users"

  app.env["SCRIPT_NAME"] = "/users/5"
  app.breadcrumbs.add("Jane Doe", "/users/jane-doe")

  assert_equal "/users/jane-doe", app.breadcrumbs.last.url
end

test "current crumb" do |app|
  app.env["SCRIPT_NAME"] = "/"
  app.breadcrumbs << "Home"

  app.env["SCRIPT_NAME"] = "/users"
  app.breadcrumbs << "Users"

  assert app.breadcrumbs.last.current?

  app.env["PATH_INFO"] = "/5"
  assert !app.breadcrumbs.last.current?
end
