#= require persona

window.ui =

  notify: (msg, cls)->
    @noticeEl
      .removeClass()
      .html(msg)
      .addClass(cls)
      .fadeIn()
    clearTimeout @noticeTimer if @noticeTimer
    @noticeTimer = setTimeout (=>
        @noticeEl.fadeOut()
      ), 1000

  _cacheDomReferences: ->
    @noticeEl = $ '#notice'

  setup: ->
    @_cacheDomReferences()
    @noticeEl.hide()

ui.setup()
