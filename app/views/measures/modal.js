id = "#<%= params[:action] %>-measure-modal"
$(id).remove();
$measureModal = $("<%= escape_javascript(render partial: 'measures/modal', locals: { measure: @measure }) %>");
$('#content').append($measureModal);
$(id).modal('show');
