jQuery ->

  # --- methods

  redraw_scrolling_div = ->
    new_width  = $('.medias').width() + 50
    new_height = $('html').height()   * 0.8
    $('.medias > .tab-content').css 'width',  new_width
    $('.medias > .tab-content').css 'height', new_height

  load_page_with_media = (page) ->
    type = $('.menu_item.active > a').attr('data-type')
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
          $('.medias > .tab-content').scrollTop(0)
        $('.thumbnail[page=' + page + '] > .thumbnail_body > img.picture').contenthover
          overlay_x_position: 'center'
          overlay_y_position: 'bottom'
          overlay_height:     85
          effect:             'fade'
          fade_speed:         300

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
    # reset page counters
    current_page = 0
    next_page    = 1
    # reset page content
    $('#movies_tab').empty()
    $('#tv_series_tab').empty()
    $('#subscriptions_tab').empty()
    # load 1st page of active tab
    load_page_with_media next_page

  # -- infinity scroll with pagination

  $('.medias > .tab-content').scroll (e) ->
    active_tab_id = $('.menu_item.active > a').attr('href')
    medias        = $('.medias > .tab-content ' + active_tab_id + ' .thumbnail.for_media')
    per_page      = medias.length

    if $(medias[medias.length - 15]).is(':appeared') && next_page > current_page
      load_page_with_media next_page
