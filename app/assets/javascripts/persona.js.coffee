id = navigator.id

class window.PersonaClient

  _login: (assertion)->
    $.ajax
      type: 'POST'
      url: '/sessions'
      data:
        assertion: assertion
      success: =>
        @loggedIn = true
        window.location.reload()
      error: (xhr, status,err)=>
        id.logout()
        ui.notify 'Login failed'

  _logout: ->
    $.ajax
      type: 'DELETE'
      url: '/sessions'
      success: (res, status, xhr)=>
        window.location.reload()
      error: =>
        if @loggedIn
          ui.notify 'Failed to Log you out'

  _setupDomHandlers: ->
    $('#signin').click ->
      ui.notify 'Attempting to log you in'
      id.request()
    $('#signout').click ->
      id.logout()

  _setupNavHandlers: ->
    meta = $('meta[name="current_user"]')
    email = null
    if meta.length > 0
      email = meta.attr 'content'
    navigator.id.watch
      loggedInUser: email
      onlogin: (a)=> @_login(a)
      onlogout: => @_logout()

  setup: ->
    @_setupDomHandlers()
    @_setupNavHandlers()
