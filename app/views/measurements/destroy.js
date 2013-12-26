newCell = $("<%= escape_javascript(render partial: 'measures/measurement', locals: { measure: @measure, measurement: nil, year: @year }) %>");

cell = $('.measurement[data-year="<%= @year %>"][data-measure="<%= @measure.id %>"]');

cell.find('.popovers').popover('destroy');
$('.popover').remove();
cell.replaceWith(newCell);

cell = $('.no-measurement[data-year="<%= @year %>"][data-measure="<%= @measure.id %>"]');
cell.addClass('success');

setTimeout(function(){
  cell.removeClass('success', 1000);
}, 3000);
