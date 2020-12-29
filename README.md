# Migajas

Migajas is a tiny library for adding breadcrumbs to any Rack application. It was
designed with routing tree frameworks like Cuba or Roda in mind, but works well
with any Rack-based framework, including Rails.

## Usage

First, build up your trail of crumbs as you match your routes:

``` ruby
Cuba.plugin Migajas

Cuba.define do
  breacrumbs << "Home"

  on "users" do
    breadcrumbs << "Users"

    on get do
      # render the list of users
    end

    on ":id" do |id|
      user = User[id]
      breadcrumbs << user.name

      on get do
        # render the user profile page
      end
    end
  end
end
```

Then, in the view, go over the `breadcrumbs` list:

``` erb
<ol class="breadcrumbs">
  <% breadcrumbs.each do |crumb| %>
    <li class="<%= "active" if crumb.current? %>">
      <a href="<%= crumb.url %>"><%= crumb.name %></a>
    </li>
  <% end %>
</ol>
```

That's it :)

## Rails

Start by adding `Migajas::Rails` to your controllers:

``` ruby
class ApplicationController < ActionController::Base
  include Migajas::Rails
end
```

This gives you a `breadcrumbs` method that you can access from your controllers
and views. The recommended approach is to use action callbacks to add
breadcrumbs:

``` ruby
class ApplicationController < ActionController::Base
  include Migajas::Rails

  before_action { breadcrumbs.add "Home", root_path }
end

class UsersController < ApplicationController
  before_action { breadcrumbs.add "Users", users_path }
  before_action(only: [:show, :edit, :update]) { breadcrumbs.add @user.name, user_path(@user) }
end
```

Then, in your layout, you can iterate over the Array:

``` erb
<ol class="breadcrumbs">
  <% breadcrumbs.each do |crumb| %>
    <%= tag.li class: { active: crumb.current? } do %>
      <%= link_to crumb.name, crumb.url %>
    <% end %>
  <% end %>
</ol>
```

## Install

    gem install migajas

## Do we need a gem for this?

Probably not, but after 2 years of using this code, I got bored of copying and
pasting it from [a gist](https://gist.github.com/foca/44c9f24a759238fba9fb).

## What's in a name?

`Migajas` is the Spanish word for `breadcrumbs`. It's pronounced like you'd
pronounce `me-gha-has` in English (`me` as in the word "me", `gha` as in
"ghast", and `has` as the word "has".)

## License

This project is shared under the MIT license. See the attached [LICENSE][] file
for details.

[LICENSE]: ./LICENSE
