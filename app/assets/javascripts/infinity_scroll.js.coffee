$(document).ready ->

  $('.episodes').scrollTop(0);

  $('.episodes').bind 'scroll', ->
    if $('.pagination').length && !$('.pagination .next_page').hasClass( "disabled" )
      
      url = $('.pagination .next_page').attr('href')

      if $(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight
        $('.pagination').text 'Please Wait...'
        return $.getScript(url)
    
    return
