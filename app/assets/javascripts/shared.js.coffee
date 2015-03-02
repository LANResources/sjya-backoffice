@browserSupportsPushState =
  window.history and window.history.pushState and window.history.replaceState and window.history.state != undefined
@initialURL = location.href
@popped = false

@page = ->
  $body = $('body')
  document.body.page ||=
    controller: $body.data('controller')
    action: $body.data('action')
    to_a: -> [@controller, @action]
    to_s: -> "#{@controller}##{@action}"

@pageIs = (controller, action) ->
  controller = [controller] unless $.isArray controller
  return false unless @page().controller in controller
  return true unless action
  action = [action] unless $.isArray action
  @page().action in action

$ ->
  highlightActiveMenuItem()
  initPopstate()
  initializeNProgress()
  removeFooterLogoOnIE()
  initBestInPlace()

  $(document).on 'page:load', ->
    highlightActiveMenuItem()
    removeFooterLogoOnIE()
    initBestInPlace()
  .on 'page:restore', highlightActiveMenuItem

initPopstate = ->
  if @browserSupportsPushState
    $(window).bind 'popstate', (e) ->
      unless history.state?.turbolinks?
        e.preventDefault()
        if location.href == initialURL and not window.popped
          window.popped = true
        else
          $.getScript(location.href) if history.state?.getScript?

initializeNProgress = ->
  $(document).on 'page:before-change', NProgress.start
  $(document).on 'page:fetch', NProgress.inc
  $(document).on 'page:receive', NProgress.inc
  $(document).on 'page:load', NProgress.done
  $(document).on 'page:restore', NProgress.remove

removeFooterLogoOnIE = ->
  if /MSIE (\d+\.\d+);/.test navigator.userAgent
    $('#footer-logo').remove()

initBestInPlace = ->
  $('.best_in_place').best_in_place()

highlightActiveMenuItem = ->
  $mainMenu = $('.main-menu')
  $mainMenu.find('li.active').removeClass 'active'

  if ($specificMatch = $mainMenu.find('li[data-active~="' + page().to_s() + '"]')).length > 0
    $specificMatch.addClass 'active'
  else
    $mainMenu.find('li[data-active~="' + page().controller + '"]').addClass 'active'
