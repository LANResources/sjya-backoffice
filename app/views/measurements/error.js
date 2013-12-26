$errors = $("<%= escape_javascript(render partial: 'shared/form_errors', locals: { resource: @measurement }) %>");
$modalBody = $("#<%= params[:action] == 'create' ? 'new' : 'edit' %>-measurement-modal").find('.modal-body');
$modalBody.prepend($errors);
