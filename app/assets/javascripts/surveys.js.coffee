$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'surveys', 'index'
    initBestInPlace()

  else if pageIs 'attempts', 'index'
    initDescriptionPopovers()

  else if pageIs 'attempts', ['new', 'create']
    initSelect2()
    initFollowUps()
    initDatepicker()

initBestInPlace = ->
  $('.best_in_place').best_in_place()

initSelect2 = ->
  $('.select2').select2()

initFollowUps = ->
  $('.follow-up-container').hide().addClass 'invalid'
  $('.question-panel.has-follow-up').each ->
    $question_panel = $(this)
    question = $question_panel.data('primary-question-id')
    $(document.body).on 'change', "[name=\"attempt[#{question}][answer_text]\"], [name=\"attempt[#{question}][answer_text][]\"]", ->
      answer = $(this).val()

      if $(this).attr('type') is 'checkbox'
        $answer = $question_panel.find(".follow-up-container[data-condition=\"#{answer}\"]")
        if $(this).attr('checked')?
          $answer.show().removeClass 'invalid'
        else
          $answer.hide().addClass 'invalid'
      else
        $question_panel.find('.follow-up-container').each ->
          $(this).hide().addClass 'invalid'
        $question_panel.find(".follow-up-container[data-condition=\"#{answer}\"]").show().removeClass 'invalid'

  $(document.body).on 'submit', '#new_attempt', ->
    $('.follow-up-container.invalid').remove()

initDatepicker = ->
  $ad = $('#activity_date')
  $ad.datepicker().on 'changeDate', ->
    $ad.datepicker 'hide'

initDescriptionPopovers = ->
  $('.description-popover').each ->
    $(this).popover
      placement: 'left'
      trigger: 'hover'
