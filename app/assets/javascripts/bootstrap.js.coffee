jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

  $(window).on 'load', ->
    $("#sidebar").height( $(window).height() - 240 );
    if $("table.table-fixedheader>tbody").length
      $("table.table-fixedheader>tbody").height( $("#sidebar").height() + 50 )
    else
      $("#films-r > .episodes").height( $("#sidebar").height() + 100 )

  $(window).on 'resize', ->
    $("#sidebar").height( $(window).height() - 240 );
    if $("table.table-fixedheader>tbody").length
      $("table.table-fixedheader>tbody").height( $("#sidebar").height() + 50 )
    else
      $("#films-r > .episodes").height( $("#sidebar").height() + 100 )

    if $(window).width() < 1200
      $("#sidebar").hide()
      $(".sideways").hide()
    else
      $("#sidebar").show()
      $(".sideways").show()
    return
  