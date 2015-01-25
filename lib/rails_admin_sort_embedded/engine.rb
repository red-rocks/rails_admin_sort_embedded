module RailsAdminSortEmbedded
  class Engine < ::Rails::Engine

    initializer "RailsAdminSortEmbedded precompile hook", group: :all do |app|
      app.config.assets.precompile += %w(rails_admin/rails_admin_sort_embedded.js rails_admin/rails_admin_sort_embedded.css)
    end

    initializer 'Include RailsAdminSortEmbedded::Helper' do |app|
      ActionView::Base.send :include, RailsAdminSortEmbedded::Helper
    end
  end
end
