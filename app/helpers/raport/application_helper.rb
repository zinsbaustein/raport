module Raport
  module ApplicationHelper
    
    def link_to_report(format = :csv, html_options = nil, &block)
      html_options.kind_of?(Hash) ? html_options.deep_merge!(data: { report: true }) : html_options = { data: { report: true } }
      link_to ['.', format].join, url_for(params.merge(format: format)), html_options, &block
    end
  end
end
