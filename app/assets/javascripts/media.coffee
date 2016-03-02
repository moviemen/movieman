jQuery ->
  
  # redraw scrolling block and hide scrollbar

  redraw_scrolling_div = ->
    new_width  = $('.medias').width() + 50
    new_height = $('html').height()   * 0.8
    $('.medias > .tab-content').css 'width',  new_width
    $('.medias > .tab-content').css 'height', new_height

  redraw_scrolling_div()

  $(window).resize ->
    redraw_scrolling_div()

  # infinity scroll with pagination

  $('.medias > .tab-content').scrollTop 0

  current_page = 0
  next_page    = 1

  $('.medias > .tab-content').scroll (e) ->
    active_tab_id = $('.menu_item.active > a').attr('href')
    medias        = $('.medias > .tab-content ' + active_tab_id + ' .thumbnail.for_media')
    per_page      = medias.length

    if $(medias[medias.length - 25]).is(':appeared') && next_page > current_page
      $.ajax
        type: 'GET'
        url:  'media/'
        data: ('page=' + next_page)
        beforeSend: ->
          current_page += 1
        success: (response) ->
          console.log 'success'
          $('#movies_tab').append response.data
          next_page += 1
        fail: (response) ->
          console.log 'fail'
          current_page -= 1