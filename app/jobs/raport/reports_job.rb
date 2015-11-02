module Raport
  class ReportsJob < ActiveJob::Base
    
    def perform(report)
      I18n.with_locale(report.locale) do 
        Raport::Report::Renderer.new(report).render
      end
    end
  end
end