id = "#<%= params[:action] %>-measurement-modal"
$(id).remove();
$measurementModal = $("<%= escape_javascript(render partial: 'measurements/modal', locals: { measure: @measure, measurement: @measurement }) %>");
$('#content').append($measurementModal);
$(id).modal('show');
