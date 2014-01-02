$('#new-measure-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

table = $('#measure-table');
newRow = $("<%= escape_javascript(render partial: 'measures/measure', locals: { measure: @measure, measurements: {}, years: @years, show_new_year_column: @show_new_year_column }) %>");
newRow.hide().appendTo(table.find('tbody'));

if (!$('#admin-mode-toggle').hasClass('active')){
  newRow.find('.modifiers').hide();
}

newRow.fadeIn();
