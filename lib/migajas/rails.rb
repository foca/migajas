require "rails/engine"
require "migajas"

module Migajas
  # Provides a bridge for Migajas to work in Rails controllers, giving you the
  # `breadcrumbs` method both in controllers and views.
  #
  # You can then add to it via action callbacks, like so:
  #
  #   class ApplicationController
  #     before_action { breadcrumbs.add "Home", root_path }
  #   end
  #
  #   class UsersController < ApplicationController
  #     before_action { breadcrumbs.add "Users", users_path }
  #     before_action(only: [:show, :edit, :update]) do
  #       breadcrumbs.add @user.name, @user
  #     end
  #   end
  #
  # You can also call `breadcrumbs.add` directly from your controller action:
  #
  #   class UsersController < ApplicationController
  #     def edit_security
  #       breadcrumbs.add "Password", edit_security_user_path(@user)
  #     end
  #   end
  #
  # Then, from the view, you can just iterate over the `breadcrumbs` trail:
  #
  #   <nav class="breadcrumbs" aria-label="Breadcrumb">
  #     <ol>
  #       <% breadcrumbs.each do |crumb| %>
  #         <li><%= link_to_unless crumb.current?, crumb.name, crumb.url %></li>
  #       <% end %>
  #     </ol>
  #   </nav>
  #
  module Rails
    extend ActiveSupport::Concern
    include Migajas

    included do
      helper_method :breadcrumbs
    end

    def migajas_env # :nodoc:
      request.env
    end
  end

  class Engine < ::Rails::Engine # :nodoc:
    initializer "migajas.helpers" do
      ActiveSupport.on_load(:action_controller_base) do
        include Migajas::Rails
      end
    end
  end
end
