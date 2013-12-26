$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'measures', 'index'
    initNewMeasurements()
    initPopovers()

initNewMeasurements = ->
  $(document.body).on 'click', '.no-measurement', ->
    $cell = $(this)
    year = parseInt $cell.data('year')
    path = $cell.data 'path'
    $.getScript path

initPopovers = ->
  $('.popovers').each ->
    $(this).popover
      placement: 'right'
      trigger: 'click'
      html: true
      container: 'body'
