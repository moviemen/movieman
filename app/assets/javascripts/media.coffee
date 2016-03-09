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
        console.log 'success'
        $('#' + type + '_tab').append response.data
        next_page += 1
      fail: (response) ->
        console.log 'fail'
        current_page -= 1
      complete: ->
        if current_page == 1
          scroll_to_top
        $('.thumbnail[page=' + page + '] > .thumbnail_body > img.picture').contenthover
          overlay_background: 'none'
          overlay_x_position: 'center'
          overlay_y_position: 'center'
          overlay_opacity:    1
          effect:             'fade'
          fade_spees:         250

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

    if $(medias[medias.length - 20]).is(':appeared') && next_page > current_page
      load_page_with_media next_page

  # -- subscription events

  $('.tab-content').on 'click', '.unsubscribe', ->
    media_id = $(this).closest('.thumbnail').attr('id')
    $.ajax
      url:     ('/subscriptions/' + media_id)
      type:    'DELETE'
      success: (response) ->
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

