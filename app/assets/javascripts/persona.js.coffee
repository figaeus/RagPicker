id = navigator.id

$('#signin').click ->
  ui.notify 'Attempting to log you in'
  id.request()
$('#signout').click ->
  id.logout()

navigator.id.watch
  loggedInUser: null,
  onlogin: (assertion)->
    $.ajax
      type: 'POST'
      url: '/sessions'
      data:
        assertion: assertion
      error: (xhr, status,err)->
        id.logout()
        ui.notify 'Login failed'
  onlogout: (assertion)->
    $.ajax
      type: 'DELETE'
      url: '/sessions'
      success: (res, status, xhr)->
        window.location.reload()
      error: (xhr, status, err)->
        ui.notify 'Failed to Log you out'
