jQuery ->
  $('#email_notifications').change ->
    $.ajax
      url: '/notifications'
      type: 'PATCH'
      data: 'mail': @checked
