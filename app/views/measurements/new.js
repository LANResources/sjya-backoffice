$('#new-measurement-modal').remove();
$newMeasurementModal = $("<%= escape_javascript(render partial: 'measurements/new_modal', locals: { measure: @measure, measurement: @measurement }) %>");
$('#content').append($newMeasurementModal);
$('#new-measurement-modal').modal('show');
