# RailsAdminSortEmbedded

Sort for Embedded documents in mongoid. Field order is need.

Bonus features:

* special case support for `cover` and `image` columns

## Installation

Add this line to your application's Gemfile:

    gem 'rails_admin_sort_embedded'

And then execute:

    $ bundle

## Usage with rails_admin

Add the sort_embedded action for each model or only for models you need

    RailsAdmin.config do |config|
      config.actions do
        ......
        sort_embedded do
          visible do
            %w(Page).include? bindings[:abstract_model].model_name
          end
        end
      end
    end

In embedded model:


    field :order, type: Integer, default: 0
    scope :sorted, -> { order_by([:order, :asc]) } #optional

In parent model:

    embeds_many :method_name
    rails_admin do        ...
        sort_embedded({
            fields: [:method_name],
            toggle_fields: [:enabled],
            thumbnail_fields: [:image, :cover],
            thumbnail_size: :thumb,
            thumbnail_gem: :paperclip, # or :carrierwave
        })
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Some ideas and code for this gem are taken from:

https://github.com/rs-pro/rails_admin_nested_set
