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

or use https://github.com/ack43/rocket_cms and:

    # generate 'order' field, 'sort' as alias and scopes 'ordered' and 'sorted'
    include SortField
    sort_field

    or

    # generate fields and scopes with prefix 'another_': 'another_order' field, 'another_sort' as alias and scopes 'another_ordered' and 'another_sorted'
    include SortField
    sort_field :another

In parent model:

    embeds_many :method_name
    rails_admin do        ...
        sort_embedded({
            fields: [{model: [:order_field_1, :order_scope_1]}, {model: [:order_field_2, :order_scope_2]}...],
            label_methods: [:name, :label],
            toggle_fields: [:enabled],
            thumbnail_fields: [:image, :cover],
            thumbnail_size: :thumb,
            thumbnail_gem: :paperclip, # or :carrierwave
        })
    end


You can not use '[:order_field_1, :order_scope_1]' and just use [:order_field_1]. Scope_name will be :order_field_1 as string + "ed"
Default field is 'order', default scope is 'ordered';

I18n:

    ru:
      rails_admin:
        sort_embedded:
          my_news:
            my_news_images: Фотогалерея

    # or with specified fields
    ru:
      rails_admin:
        sort_embedded:
          my_news:
            my_news_images:
              order: Фотогалерея
              another_order: Фотогалерея(alt)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Some ideas and code for this gem are taken from:

https://github.com/rs-pro/rails_admin_nested_set
