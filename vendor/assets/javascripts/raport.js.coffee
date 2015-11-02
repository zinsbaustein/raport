#= require raport/periodic
  
peridicallyCall = (dom) ->
  $.periodic ->
    period: 5000
    $.ajax
      periodic: this
      url: $(dom).data('async-load-report')
      success: (json) ->
        if $.inArray(json.state, ['finished', 'failed']) != -1
          $('#report-download').html '<a href="' + json.file.url + '" class="label label-info">Download</a>'
          $(dom).replaceWith '<span class="' + json.status_css_classes + '">' + json.display_status_name + '</span>'
          @periodic.cancel()
      complete: (xhr, status) ->
        @ajax_complete
      dataType: 'json'
      
$(document).ready ($) ->  
  $('[data-async-load-report]').each (i, dom) ->
    peridicallyCall dom
    return
    
  $('[data-report="true"]').each (i, dom) ->
    $(dom).on 'click', (e) ->
      e.preventDefault()
      $.ajax(
        type: "GET"
        url: $(dom).attr 'href'
        dataType: 'json'
      ).done (json) ->
        if json.errors
          $.each json.errors, (key, values) ->
            $.each values, (i, value) ->
              console.log value
            return
        else
          window.location.replace json.permalink
        return
      

