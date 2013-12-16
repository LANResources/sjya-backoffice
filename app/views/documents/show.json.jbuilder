json.extract! @document, :id, :title, :tag_list, :content_type, :created_at, :updated_at
json.item_size number_to_human_size(@document.item_size)
json.url document_path(@document)
json.remove_link link_to('remove', @document, method: :delete, data: { remote: true })
