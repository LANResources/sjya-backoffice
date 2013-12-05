$ ->
   initPage()
   $(document).on 'page:load', initPage

initPage = ->
  if pageIs 'documents', 'new'
    initDocumentUploadForm()

Dropzone.autoDiscover = false

initDocumentUploadForm = ->
  Dropzone.options.newDocument =
    paramName: "document[item]"
    autoProcessQueue: false
    clickable: '.dropzone-activator'
    previewsContainer: '.dropzone-previews'
    createImageThumbnails: true
    previewTemplate: Mustache.render($('#dz-preview-template').html())
    uploadMultiple: false
    parallelUploads: 100
    maxFiles: 100
    thumbnailWidth: 64
    thumbnailHeight: 64
    acceptedFiles: $('.dropzone').data('accepts').join(',')
    sending: (file, xhr, formData) ->
      title = $(file.previewElement).find('.title-input').val()
      formData.append 'document[title]', title
    init: ->
      newDocumentDropzone = this
      $(this.element).find("input[type='submit']").on 'click', (e) ->
        e.preventDefault()
        e.stopPropagation()
        newDocumentDropzone.processQueue()

      this.on 'addedfile', (file) ->
        $(file.previewElement).find('.remove-file').on 'click', (e) ->
          e.preventDefault()
          e.stopPropagation()
          if file.status == Dropzone.UPLOADING
            Dropzone.confirm newDocumentDropzone.options.dictCancelUploadConfirmation, => newDocumentDropzone.removeFile file
          else
            if newDocumentDropzone.options.dictRemoveFileConfirmation
              Dropzone.confirm newDocumentDropzone.options.dictRemoveFileConfirmation, => newDocumentDropzone.removeFile file
            else
              newDocumentDropzone.removeFile file

      this.on 'success', (file, response) ->
        $container = $(file.previewElement)
        $container.find('.progress').hide()
        $titleDisplay = $("<div></div>").text response.title
        $container.find('.title-input').replaceWith $titleDisplay
        $container.find('.remove-file').replaceWith $(response.remove_link)

      this.on 'error', (file, message, xhr) ->
        $container = $(file.previewElement)
        $container.find('.title-input').hide()
        $container.find('.progress').hide()
        $container.find('[data-dz-errormessage]').html(message.join('<br/>')) if $.isArray message

  Dropzone.discover()
