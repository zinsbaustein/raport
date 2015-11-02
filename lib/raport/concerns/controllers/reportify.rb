module Raport
  module Reportify
    extend ActiveSupport::Concern
    
    # TODO move this to configuration
    REPORTABLE_FORMATS  = [:csv]
  
    included do
      helper_method :report_attributes
      
      respond_to *REPORTABLE_FORMATS, :html
      
      report only: :index
    end
  
    def create_report
      if REPORTABLE_FORMATS.include?(request.format.to_sym)
        @report = current_admin.reports.create(report_attributes)

        respond_to do |format|
          format.any do 
            if request.xhr?
              render json: @report.errors.empty? ? @report.as_json(methods: :permalink) : { errors: @report.errors }.to_json
            else
              redirect_to polymorphic_path([current_namespace, @report])
            end
          end
        end
      end
    end
  
    protected
  
    def report_attributes
      {
        action_name: action_name,
        select: collection.select_values,
        joins: collection.joins_values,
        where: formatted_sql_values(collection.where_values),
        resource_class_name: resource_class.name, 
        template: current_template, 
        locale: I18n.locale
      }
    end
  
    private

    def formatted_sql_values(values)
      values.kind_of?(Array) ? values.map { |value| value.respond_to?(:to_sql) ? value.to_sql : value }.join(' AND ') : nil
    end
  
    def current_template
      lookup_context.find(action_name, lookup_context.prefixes, false, [], formats: [request.format.to_sym]).inspect
    end
  
    class_methods do
      def report(options = {}, &block)
        before_action :create_report, options, &block
      end
    end
  end
end