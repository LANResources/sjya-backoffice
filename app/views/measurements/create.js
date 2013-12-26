$('#new-measurement-modal').on('hidden.bs.modal', function(){ $(this).remove(); }).modal('hide');

newCell = $("<%= escape_javascript(render partial: 'measures/measurement', locals: { measure: @measure, measurement: @measurement, year: @measurement.year }) %>");

cell = $('.no-measurement[data-year="<%= @measurement.year %>"][data-measure="<%= @measurement.measure_id %>"]');
cell.replaceWith(newCell);

cell = $('.measurement[data-year="<%= @measurement.year %>"][data-measure="<%= @measurement.measure_id %>"]');
cell.find('.popovers').popover({placement: 'right', trigger: 'click', html: true, container: 'body'});
cell.addClass('success');

setTimeout(function(){
  cell.removeClass('success');
}, 3000);
