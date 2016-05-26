module Migajas
  # Public: List of breadcrumbs encountered in this request. Add to this list
  # any breadcrumb as you go through your routing tree in the app:
  #
  # Example
  #
  #   define do
  #     breadcrumbs << "Home"
  #
  #     on "users" do
  #       breadcrumbs << "Users"
  #
  #       on get do
  #         # render the list
  #       end
  #
  #       on ":id" do |id|
  #         user = User[id]
  #         breadcrumbs << user.name
  #
  #         # etc
  #       end
  #     end
  #   end
  #
  #   This will automatically build a list with the following breadcrumbs:
  #
  #   [
  #     Migajas::Crumb.new("Home", "/"),
  #     Migajas::Crumb.new("Users", "/users"),
  #     Migajas::Crumb.new("Profile", "/users/5")
  #   ]
  #
  #   In the view you can, then:
  #
  #   <% breadcrumbs.each do |crumb| %>
  #     <li class="<%= "active" if crumb.current? %>">
  #       <a href="<%= crumb.url %>"><%= crumb.name %></a>
  #     </li>
  #   <% end %>
  #
  # Returns a Migajas::Trail.
  def breadcrumbs
    env["app.breadcrumbs"] ||= Trail.new(env)
  end

  # The Trail is just an `env`-aware Array, with some convenient sugar for
  # adding items to it.
  class Trail < Array
    def initialize(env)
      @env = env
      super()
    end

    # Add a new crumb to this trail. This takes care of calculating the URL
    # from the path currently matched by Cuba, so all you need to provide is
    # the name.
    #
    # Returns self.
    def add(name, url = @env["SCRIPT_NAME"])
      push Crumb.new(name, url, @env)
    end
    alias_method :<<, :add

    # Crumbs are dumb values that know their #name, their #url, and whether
    # they match the current URL (according to the `env`, which they inherit
    # from their trail).
    class Crumb
      attr_reader :name, :url

      def initialize(name, url, env)
        @name = name
        @url = url
        @env = env
      end

      def current?
        url == (@env["SCRIPT_NAME"] + @env["PATH_INFO"])
      end
    end
  end
end
