$('tr.measure[data-measure="<%= params[:id] %>"]').fadeOut(1000, function(){
  $(this).remove();
});
