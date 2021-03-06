# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.actions').hide

  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

  $('.media-body').hover \
      (-> $(this).find('.actions').fadeIn(150)), \
      (-> $(this).find('.actions').fadeOut(150))
