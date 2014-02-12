# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
    $('.followers_avatars').hide()
    $('.followings_avatars').hide()
    $('#followers').click ->
        $('.followers_avatars').show()
        $('.followings_avatars').hide()
    $('#followings').click ->
        this.preventDefault
        $('.followers_avatars').hide()
        $('.followings_avatars').show()