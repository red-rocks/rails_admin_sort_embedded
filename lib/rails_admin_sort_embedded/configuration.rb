module RailsAdminSortEmbedded
  class Configuration
    def initialize(abstract_model)
      @abstract_model = abstract_model
    end

    def options
      @options ||= {
          fields: [],
          thumbnail_fields: [:image, :cover],
          thumbnail_size: :thumb,
          thumbnail_gem: :paperclip,
      }.merge(config || {})
    end

    protected
    def config
      ::RailsAdmin::Config.model(@abstract_model.model).sort_embedded || {}
    end
  end
end
