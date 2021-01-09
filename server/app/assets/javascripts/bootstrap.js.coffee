jQuery ->
  $('.actions').hide
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

  $('.media-body').hover \
      (-> $(this).find('.actions').fadeIn(150)), \
      (-> $(this).find('.actions').fadeOut(150))
