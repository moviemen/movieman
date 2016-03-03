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
    $('#movies_tab').empty();
    $('#tv_series_tab').empty();
    $('#subscriptions_tab').empty();

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
      complete:
        if current_page == 1
          scroll_to_top

  # -- init page

  current_page = 0
  next_page    = 1

  load_page_with_media next_page

  # -- redraw scrolling block and hide scrollbar

  redraw_scrolling_div()

  $(window).resize ->
    redraw_scrolling_div()

  # -- tabs show events

  $('a[data-toggle="tab"]').on 'shown.bs.tab', (e) ->
    current_page = 0
    next_page    = 1
    reset_page_content
    load_page_with_media next_page

  # -- infinity scroll with pagination

  $('.medias > .tab-content').scroll (e) ->
    active_tab_id = $('.menu_item.active > a').attr('href')
    medias        = $('.medias > .tab-content ' + active_tab_id + ' .thumbnail.for_media')
    per_page      = medias.length

    if $(medias[medias.length - 25]).is(':appeared') && next_page > current_page
      load_page_with_media next_page