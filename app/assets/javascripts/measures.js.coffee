$ ->
  initPage()
  $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'measures', 'index'
    initAdminMode()
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

initAdminMode = ->
  $('.modifiers').hide()
  $(document.body).on 'click', '#admin-mode-toggle', ->
    $('.modifiers').toggle()
    $toggleBtn = $(this)
    buttonText = $toggleBtn.find('.state').text()
    buttonText = if buttonText.match(/Off/) then ' On' else ' Off'
    $toggleBtn.find('.state').text buttonText
