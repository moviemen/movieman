$('#search').on 'input', ->
  if $('#search').val().length >= 3
    media_kind = $('.menu_item.active > a').attr('data-type')
    search_form = $('#search_form')
    search_form.submit (response) ->
    $.ajax
      type: search_form.attr('method')
      url: search_form.attr('action')
      data: search_form.serialize() + '&' + 'media_kind='+media_kind
      success: (data) ->
        console.log('ok')
