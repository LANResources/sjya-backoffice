$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'questions', ['new', 'edit']
    initQuestionForm()

initQuestionForm = ->
  initSectionsAutocomplete()

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
      updateFollowUpConditions id
      $follow_up_for_condition_row.show()
    else
      $follow_up_for_condition_row.hide().find('#question_follow_up_for_condition').val('')

  $('#question_follow_up_for_id, #question_type').change()

initSectionsAutocomplete = ->
  $sectionInput = $('#question_section')
  sections = $sectionInput.data 'sections'
  if sections
    $sectionInput.typeahead
      name: 'sections'
      local: sections

updateFollowUpConditions = (question) ->
  $conditionSelect = $('#question_follow_up_for_condition')
  $conditionSelect.val('')
  answers = $conditionSelect.data('answers')[question]
  answerOptions = ''
  answerOptions += "<option class=\"answer\" value=\"#{answer}\">#{answer}</option>" for answer in answers
  $conditionSelect.find('option.answer').remove()
  $conditionSelect.append $(answerOptions)
