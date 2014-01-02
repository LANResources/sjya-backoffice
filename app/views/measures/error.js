$errors = $("<%= escape_javascript(render partial: 'shared/form_errors', locals: { resource: @measure }) %>");
$modalBody = $("#<%= params[:action] == 'create' ? 'new' : 'edit' %>-measure-modal").find('.modal-body');
$modalBody.prepend($errors);
