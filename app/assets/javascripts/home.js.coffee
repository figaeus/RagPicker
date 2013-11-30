#= require utils/ajax
#= require persona

window.ui =

  notify: (msg, cls)->
    @noticeEl
      .removeClass()
      .html(msg)
      .addClass(cls || '')
      .fadeIn()
    clearTimeout @noticeTimer if @noticeTimer
    @noticeTimer = setTimeout (=>
        @noticeEl.fadeOut()
      ), 1000

  _cacheDomReferences: ->
    @noticeEl = $ '#notice'
    @noticeEl.hide()

  _setupPersona: ->
    @personaClient = new PersonaClient
    @personaClient.setup()

  setup: ->
    @_cacheDomReferences()
    @_setupPersona()

ui.setup()
