module Raport
  class ReportsJob < ActiveJob::Base
    rescue_from ActiveJob::DeserializationError do |exception|
      Honeybadger.notify(exception) if defined?(Honeybadger)
    end
    
    def perform(report)
      I18n.with_locale(report.locale) do 
        Raport::Report::Renderer.new(report).render
      end
    end
  end
end