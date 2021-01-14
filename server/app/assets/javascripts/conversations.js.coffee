do ->
  $(document).on 'click', '.toggle-window', (e) ->
    e.preventDefault()
    panel = $(this).parent().parent()
    messages_list = panel.find('.messages-list')
    panel.find('.panel-body').toggle()
    panel.attr 'class', 'panel panel-default'
    if panel.find('.panel-body').is(':visible')
      height = messages_list[0].scrollHeight
      messages_list.scrollTop height
    return
  return