$('#edit-measurement-modal').remove();
$editMeasurementModal = $("<%= escape_javascript(render partial: 'measurements/edit_modal', locals: { measure: @measure, measurement: @measurement }) %>");
$('#content').append($editMeasurementModal);
$('#edit-measurement-modal').modal('show');
