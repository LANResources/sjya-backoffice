$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'users', 'show'
    initDescriptionPopovers()


initDescriptionPopovers = ->
  $('.description-popover').each ->
    $(this).popover
      placement: 'right'
      trigger: 'hover'
