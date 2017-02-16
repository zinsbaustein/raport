module Raport
  module Reportify
    extend ActiveSupport::Concern
  
    included do
      helper_method :report_attributes
      
      respond_to *REPORTABLE_FORMATS, :html
      
      report only: :index
    end
    
    def current_report_owner
      current_user
    end
  
    def create_report
      if Raport.config.formats.include?(request.format.to_sym)
        @report = current_report_owner.reports.create(report_attributes)

        respond_to do |format|
          format.any do 
            if request.xhr?
              json = @report.errors.empty? ? @report.as_json(methods: :permalink) : { errors: @report.errors }.to_json
              render json: json
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
        where: collection.where_values_hash,
        resource_class_name: resource_class.name, 
        template: current_template, 
        locale: I18n.locale
      }
    end
  
    private
  
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