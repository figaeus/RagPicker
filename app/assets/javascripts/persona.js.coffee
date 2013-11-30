$('#signin').click ->
  navigator.id.request()
$('#signout').click ->
  navigator.id.logout()

navigator.id.watch
  loggedInUser: null,
  onlogin: (assertion)->
    alert assertion
  onlogout: (assertion)->
    alert assertion

