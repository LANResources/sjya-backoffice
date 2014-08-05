highchartsColorsSet = false

$ ->
  initPage()
  $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'reports', 'show'
    initDateRangePicker()
    initMatrixChart()
    initActivityTableModal()

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
    
    url = window.location.href.split('?')[0]
    url = "#{url}?start_date=#{start_date}&end_date=#{end_date}"
    Turbolinks.visit url
    
initMatrixChart = ->
  $chart = $('#activity-chart')
  if $chart
    data = $chart.data 'series'
    title = $chart.data 'title'

    unless highchartsColorsSet
      Highcharts.getOptions().colors = Highcharts.map Highcharts.getOptions().colors, (color) ->
        return {
          radialGradient: { cx: 0.5, cy: 0.3, r: 0.7 },
          stops: [
            [0, color],
            [1, Highcharts.Color(color).brighten(-0.3).get('rgb')] # darken
          ]
        }
      highchartsColorsSet = true
    
    $chart.highcharts
      credits: false
      chart: 
        plotBackgroundColor: null
        plotBorderWidth: null
        plotShadow: false
      title:
        text: title
      tooltip:
        pointFormat: '{series.name}: <b>{point.percentage:.0f}%</b>'
      plotOptions:
        pie:
          allowPointSelect: true
          cursor: 'pointer'
          dataLabels:
            enabled: true
            formatter: ->
              n = this.point.name.split(' - ')
              n = ("<b>#{i}</b>" for i in n).join('<br/>')
              p = parseInt this.point.percentage
              "#{n}: #{p}%"
            style:
              color: (Highcharts.theme and Highcharts.theme.contrastTextColor) or 'black'
            connectorColor: 'silver'
      series: [{
        type: 'pie'
        name: 'Activity Share'
        data: data
      }]

initActivityTableModal = ->
  if $modal = $('#activity-table-modal')
    $modal.appendTo $('body')
    $(document.body).on 'click', '.activity-table-modal-trigger', (e) ->
      e.preventDefault()
      content = $(this).data 'content'
      title = "#{$(this).data('title')} Activities"
      $modal = $('#activity-table-modal')
      $modal.find('.modal-title').text title
      $modal.find('.modal-body').html content
      $modal.modal()

