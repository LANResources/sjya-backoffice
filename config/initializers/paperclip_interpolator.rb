require 'erb'

# ensure that escaped_filename for all attachments is actually escaped
Paperclip.interpolates('escaped_filename') do |attachment, style|
  ERB::Util.url_encode(basename(attachment, style)) + "." + extension(attachment, style)
end
