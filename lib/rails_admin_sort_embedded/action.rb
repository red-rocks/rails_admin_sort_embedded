module RailsAdmin
  module Config
    module Actions
      class SortEmbedded < Base
        RailsAdmin::Config::Actions.register(self)

        # Is the action acting on the root level (Example: /admin/contact)
        register_instance_option :root? do
          false
        end

        register_instance_option :collection? do
          false
        end

        # Is the action on an object scope (Example: /admin/team/1/edit)
        register_instance_option :member? do
          true
        end

        register_instance_option :route_fragment do
          'sort_embedded'
        end

        register_instance_option :controller do
          Proc.new do |klass|
            @sort_conf = ::RailsAdminSortEmbedded::Configuration.new @abstract_model

            if params['id'].present?
              if request.get?
                # @nodes = list_entries(@model_config, :index, nil, nil).sort { |a,b| a.lft <=> b.lft }
                render action: @action.template_name

              elsif request.post?
                begin
                  ids             = params[:ids_array].to_s.split(" ")
                  embedded_model  = params[:embedded_model].to_s
                  embedded_field  = params[:embedded_field].to_s

                  embedded_model_order_field  = params[:embedded_model_order_field].to_s
                  embedded_model_order_field  = "order" if embedded_model_order_field.blank?

                  # item_id         = params[:item_id].to_s
                  # parent_id       = params[:parent_id].to_s
                  # prev_id         = params[:prev_id].to_s
                  # next_id         = params[:next_id].to_s

                  if ids.empty?
                    return render text: 'Nested set UI error: node ids not defined', status: 500
                  end

                  main_obj = @object
                  embedded = main_obj.send(embedded_field)
                  ids.each_with_index do |id, i|
                    embedded.find(id).update(embedded_model_order_field.to_sym => i)
                  end

                  message = "<strong>#{I18n.t('admin.actions.sort_embedded.success')}!</strong>"
                rescue Exception => e


                  main_obj = @object
                  embedded = main_obj.send(embedded_field).sorted
                  ids.each_with_index do |id, i|
                    embedded.find(id).update(embedded_model_order_field.to_sym => i)
                  end

                  message = "<strong>#{I18n.t('admin.actions.sort_embedded.error')}</strong>: #{e}"
                end

                render text: message
              end
            end
          end
        end

        register_instance_option :link_icon do
          'icon-move'
        end

        register_instance_option :http_methods do
          [:get, :post]
        end
      end
    end
  end
end
