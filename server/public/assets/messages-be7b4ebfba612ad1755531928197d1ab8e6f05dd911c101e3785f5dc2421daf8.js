(function(){new EventSource("/messages/events").addEventListener("messages.create",function(e){var t;return t=$.parseJSON(e.data).message,$("#chat").append($("<li>").text(t.name+": "+t.content))})}).call(this);