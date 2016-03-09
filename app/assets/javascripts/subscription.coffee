# -- unsubscribe

$('.tab-content').on 'click', '.unsubscribe', ->
  media_id      = $(this).closest('.thumbnail').attr('id')
  active_tab_id = $('.menu_item.active > a').attr('href')
  $.ajax
    url:     ('/subscriptions/' + media_id)
    type:    'DELETE'
    success: (response) ->
      if active_tab_id == '#subscriptions_tab'
        $('.thumbnail[id=' + media_id + ']').remove()
        return
      else
        subscribe_tag = $('.tab-content').find('.subscribe[media_id=' + media_id + ']')
        subscribe_tag.removeClass('hidden').show()

        unsubscribe_tag = subscribe_tag.next()
        unsubscribe_tag.hide()

        $('#action_' + media_id).text('SUBSCRIBE')

# -- subscribe

$('.tab-content').on 'click', '.subscribe', ->
  media_id = $(this).closest('.thumbnail').attr('id')
  $.ajax
    url:     '/subscriptions'
    data:    ('id=' + media_id)
    type:    'POST'
    success: (response) ->
      subscribe_tag = $('.tab-content').find('.subscribe[media_id=' + media_id + ']')
      subscribe_tag.hide()

      unsubscribe_tag = subscribe_tag.next()
      unsubscribe_tag.removeClass('hidden').show()

      $('#action_' + media_id).text('UNSUBSCRIBE')