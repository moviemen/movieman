jQuery ->
  $('#email_notifications').change ->
    $.ajax
      url: '/notifications'
      type: 'PATCH'
      data: 'mail': @checked

  $('#facebook_notifications').change ->
    $.ajax
      url: '/notifications'
      type: 'PATCH'
      data: 'facebook': @checked

  $('#vkontakte_notifications').change ->
    $.ajax
      url: '/notifications'
      type: 'PATCH'
      data: 'vkontakte': @checked

  $('#twitter_notifications').change ->
    $.ajax
      url: '/notifications'
      type: 'PATCH'
      data: 'twitter': @checked
