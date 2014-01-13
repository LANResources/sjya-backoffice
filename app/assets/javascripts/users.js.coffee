$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'users', 'show'
    initDescriptionPopovers()

  if pageIs 'users', ['new', 'create', 'edit', 'update']
    initInvitationWarning()

initDescriptionPopovers = ->
  $('.description-popover').each ->
    $(this).popover
      placement: 'right'
      trigger: 'hover'

initInvitationWarning = ->
  if pageIs('users', ['edit', 'update']) and $('#user_role').val() isnt 'contact'
    $('#invitation-warning').hide()
  else
    $(document.body).on 'change', '#user_role', ->
      if $(this).val() is 'contact'
        $('#invitation-warning').hide()
      else
        $('#invitation-warning').show()

    $('#user_role').change()
