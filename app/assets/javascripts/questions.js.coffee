$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'questions', ['new', 'edit']
    initQuestionForm()

initQuestionForm = ->
  $(document.body).on 'change', '#question_type', ->
    type = $(this).val().split('::').pop()
    $aggregatable = $('.aggregatable')
    if type in ['Checkbox', 'Radio', 'Select', 'MultiSelect']
      $aggregatable.show()
    else
      $aggregatable.hide().each ->
        $(this).find('input, textarea').each ->
          $(this).val ''
          $(this).removeAttr 'checked'

  $(document.body).on 'change', '#question_follow_up_for_id', ->
    $follow_up_for_condition_row = $('.follow_up_for_condition_row')
    if id = $(this).val()
      $follow_up_for_condition_row.show()
    else
      $follow_up_for_condition_row.hide().find('#question_follow_up_for_condition').val('')

  $('#question_follow_up_for_id, #question_type').change()
