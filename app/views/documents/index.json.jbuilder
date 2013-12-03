json.array!(@documents) do |document|
  json.extract! document, 
  json.url document_url(document, format: :json)
end
