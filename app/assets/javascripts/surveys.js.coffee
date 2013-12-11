$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'surveys'
    initSurveyForm()

initSurveyForm = ->
