json.array!(@file_lists) do |file_list|
  json.extract! file_list, :id, :disk, :filename
  json.url file_list_url(file_list, format: :json)
end
