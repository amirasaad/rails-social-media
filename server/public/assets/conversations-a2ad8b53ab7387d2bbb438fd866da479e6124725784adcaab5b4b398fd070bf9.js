(function(){$(document).on("click",".toggle-window",function(l){var e,n,t;l.preventDefault(),n=(t=$(this).parent().parent()).find(".messages-list"),t.find(".panel-body").toggle(),t.attr("class","panel panel-default"),t.find(".panel-body").is(":visible")&&(e=n[0].scrollHeight,n.scrollTop(e))})}).call(this);