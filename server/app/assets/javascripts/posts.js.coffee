# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
   $('.actions').hide
   $('#body').hover \
        (-> $(this).find('.actions').fadeIn(150)), \
        (-> $(this).find('.actions').fadeOut(150))
