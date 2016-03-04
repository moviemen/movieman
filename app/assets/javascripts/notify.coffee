$('.email_subscribe').bind 'change', ->
  $.ajax
    url: '/notifications/' + @value + '/subscribe_via_email'
    type: 'POST'
    data: 'email_subscribed': @checked