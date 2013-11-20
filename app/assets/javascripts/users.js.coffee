$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'users', ['new', 'edit']
    initUserForm()


initUserForm = ->
