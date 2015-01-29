$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'attempts', 'index'
    initDateRangePicker()

  else if pageIs 'attempts', ['new', 'create', 'edit', 'update']
    initSelect2()
    initFollowUps()
    initDatepicker()
    initActivityTypeSelect()
    initMultiObjectQuestions()

initDateRangePicker = ->
  $element = $('#daterange')
  minDate = $element.data 'mindate'
  maxDate = $element.data 'maxdate'

  $element.daterangepicker
    opens: 'left'
    minDate: minDate
    maxDate: maxDate
  .on 'apply.daterangepicker', (ev, picker) ->
    start_date = picker.startDate.format('YYYY-MM-DD')
    end_date = picker.endDate.format('YYYY-MM-DD')

    url = $('#daterangepicker-container').data('url') or window.location.href
    [url, path] = url.split('?')
    path = if path? then "&#{path}" else ""
    url = "#{url}?start_date=#{start_date}&end_date=#{end_date}#{path}"
    Turbolinks.visit url

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

initActivityTypeSelect = ->
  $(document.body).on 'change', '#activity_type_select', ->
    if $(this).val() is ''
      $('#activity_type_custom').show()
    else
      $('#activity_type_custom').hide().val('')

  $('#activity_type_select').change()

  $(document.body).on 'submit', '#new_attempt, .edit_attempt', ->
    $activityTypeInput = $('#activity_type')
    if (selectVal = $('#activity_type_select').val()) is ''
      $activityTypeInput.val $('#activity_type_custom').val()
    else
      $activityTypeInput.val selectVal

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

