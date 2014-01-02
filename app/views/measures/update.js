$('#edit-measure-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

table = $('#measure-table');
newRow = $("<%= escape_javascript(render partial: 'measures/measure', locals: { measure: @measure, measurements: @measurements, years: @years, show_new_year_column: @show_new_year_column }) %>");

row = table.find('tr.measure[data-measure="<%= @measure.id %>"]');

row.find('.popovers').each(function(){
  $(this).popover('destroy');
  $(this).remove();
});

row.replaceWith(newRow);

row = table.find('tr.measure[data-measure="<%= @measure.id %>"]');

if (!$('#admin-mode-toggle').hasClass('active')){
  row.find('.modifiers').hide();
}

row.find('.popovers').each(function(){
  $(this).popover({placement: 'right', trigger: 'click', html: true, container: 'body'});
});
row.addClass('success');

setTimeout(function(){
  row.removeClass('success', 1000);
}, 3000);
