# Migajas

Migajas is a tiny library for adding breadcrumbs to a routing tree framework,
like Cuba or Roda.

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

## Install

    gem install migajas

## What's in a name?

`Migajas` is the Spanish word for `breadcrumbs`. It's pronounced like you'd
pronounce `meegahas` in English (or `miˈɣa.xas` if you're a language nerd.)

## License

This project is shared under the MIT license. See the attached [LICENSE][] file
for details.

[LICENSE]: ./LICENSE
