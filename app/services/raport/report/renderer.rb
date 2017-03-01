module Raport
  class Report
    class Renderer
      
      attr_accessor :report
      
      attr_reader :tmpfile, :view
      
      def initialize(report)
        @report = report
        @view ||= begin
          view = ActionView::Base.new
          view.view_paths = ActionController::Base.view_paths
          view.extend ApplicationHelper
          view
        end
        @tmpfile ||= begin
          tmpfile = Tempfile.new(report.tmp_filename)
          tmpfile.write(render_view)
          tmpfile
        end
      end
      
      def render
        begin
          report.activate
          report.file = tmpfile
          report.finish
          
          
          Rails.logger.info '#######################################'
          Rails.logger.info report.inspect
          Rails.logger.info '#######################################'
          
        rescue => e
          
          Rails.logger.info '#######################################'
          Rails.logger.info e.message
          Rails.logger.info '#######################################'
          
          report.last_error = [e.message, e.backtrace.join("\n")].join("\n")
          report.flop
          raise
        ensure
          tmpfile.close

          case tmpfile.class.name
            when 'Tempfile' then tmpfile.unlink
            when 'File' then File.unlink(tmpfile.path)
          end
        end
      end
      
      private
      
      def view_attributes
        view_attributes = {
          layout: false,
          formats: [report.format],
          template: report.template_path,
          locals: {
            collection: report.collection,
            resource_class: report.resource_class,
            params: {}
          }
        }
      end
    
      def render_view
        view.render(view_attributes)
      end
      
    end
  end
end