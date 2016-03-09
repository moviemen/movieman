jQuery ->

  # --- methods

  page_type = ->
    $('.menu_item.active > a').attr('data-type')

  redraw_scrolling_div = ->
    new_width  = $('.medias').width() + 50
    new_height = $('html').height()   * 0.8
    $('.medias > .tab-content').css 'width',  new_width
    $('.medias > .tab-content').css 'height', new_height

  reset_page_content = ->
    $('#movies_tab').empty()
    $('#tv_series_tab').empty()
    $('#subscriptions_tab').empty()

  scroll_to_top = ->
    $('.medias > .tab-content').scrollTop(0)

  load_page_with_media = (page) ->
    type = page_type()
    $.ajax
      type: 'GET'
      url:  (type + '/')
      data: ('page=' + page)
      beforeSend: ->
        current_page += 1
      success: (response) ->
        $('#' + type + '_tab').append response.data
        next_page += 1
      fail: (response) ->
        current_page -= 1
      complete: ->
        if current_page == 1
          scroll_to_top
        $('.thumbnail[page=' + page + '] > .thumbnail_body > img.picture').contenthover
          overlay_x_position: 'center'
          overlay_y_position: 'bottom'
          overlay_height:     85
          effect:             'slide'
          slide_speed:        300
          slide_direction:    'bottom'

  # -- init page

  current_page = 0
  next_page    = 1

  if $('.medias').length > 0
    load_page_with_media next_page

  # -- redraw scrolling block and hide scrollbar

  redraw_scrolling_div()

  $(window).resize ->
    redraw_scrolling_div()

  # -- tabs show events

  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
    current_page = 0
    next_page    = 1
    reset_page_content()
    load_page_with_media next_page

  # -- infinity scroll with pagination

  $('.medias > .tab-content').scroll (e) ->
    active_tab_id = $('.menu_item.active > a').attr('href')
    medias        = $('.medias > .tab-content ' + active_tab_id + ' .thumbnail.for_media')
    per_page      = medias.length

    if $(medias[medias.length - 15]).is(':appeared') && next_page > current_page
      load_page_with_media next_page

  # -- subscription events

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


  # -- search events

  $('#search').on 'input', ->
    if $('#search').val().length >= 3
      search_form = $('#search_form')
      search_form.submit (response) ->
      $.ajax
        type: search_form.attr('method')
        url: search_form.attr('action')
        data: search_form.serialize()
        success: (data) ->
          console.log('ok')
