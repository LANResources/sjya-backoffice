$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'users', 'show'
    initDescriptionPopovers()

  if pageIs 'users', ['new', 'create']
    initInvitationWarning()

initDescriptionPopovers = ->
  $('.description-popover').each ->
    $(this).popover
      placement: 'right'
      trigger: 'hover'

initInvitationWarning = ->
  $(document.body).on 'change', '#user_role', ->
    if $(this).val() is 'contact'
      $('#invitation-warning').hide()
    else
      $('#invitation-warning').show()

  $('#user_role').change()
