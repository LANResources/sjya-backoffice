$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'attempts', 'index'
    initDescriptionPopovers()

  else if pageIs 'attempts', ['new', 'create', 'edit', 'update']
    initSelect2()
    initFollowUps()
    initDatepicker()
    initActivityTypeAutocomplete()
    initMultiObjectQuestions()

initSelect2 = ->
  $('.select2').select2()

initFollowUps = ->
  $('.follow-up-container').not('.show-initially').hide().addClass 'invalid'
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

  $(document.body).on 'submit', '#new_attempt, .edit_attempt', ->
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

initActivityTypeAutocomplete = ->
  $activityTypeInput = $('#activity_type')
  types = $activityTypeInput.data 'types'
  if types
    $activityTypeInput.typeahead
      name: 'types'
      local: types

initMultiObjectQuestions = ->
  $(document.body).on 'click', '.add-object-btn', ->
    $panel = $(this).parents('.panel-body')
    $objectsContainer = $panel.find('.objects-container')
    index = $objectsContainer.find('.form-group').size()
    template = Mustache.render $("##{$(this).data('template')}").html(), { index: index }
    $objectsContainer.append(template)

  $(document.body).on 'click', '.remove-object-btn', ->
    $(this).parents('li').remove()

  $(document.body).on 'submit', '#new_attempt, .edit_attempt', ->
    $('.objects-container').each ->
      $input = $(this).parents('.panel-body').find('.objects-input')
      $objects = $(this).find('li')
      if $objects.size is 0
        $input.val ''
      else
        newVal = ''
        $objects.each ->
          obj = []
          $(this).find('input').each ->
            obj.push $(this).data('property') + '=' + $(this).val()
          newVal += obj.join(',') + ';'
        $input.val newVal

