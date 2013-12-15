$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'surveys', 'index'
    initBestInPlace()

  else if pageIs 'attempts', 'new'
    initSelect2()
    initFollowUps()
    initDatepicker()

initBestInPlace = ->
  $('.best_in_place').best_in_place()

initSelect2 = ->
  $('.select2').select2()

initFollowUps = ->
  $('.follow-up-container').hide()
  $('.question-panel.has-follow-up').each ->
    $question_panel = $(this)
    question = $question_panel.data('primary-question-id')
    $(document.body).on 'change', "[name=\"attempt[#{question}][answer_text]\"]", ->
      answer = $(this).val()
      $question_panel.find('.follow-up-container').each ->
        $(this).hide().addClass 'invalid'
      $question_panel.find(".follow-up-container[data-condition=\"#{answer}\"]").show().removeClass 'invalid'

  $(document.body).on 'submit', '#new_attempt', ->
    $('.follow-up-container.invalid').remove()

initDatepicker = ->
  $('#activity_date').datepicker()