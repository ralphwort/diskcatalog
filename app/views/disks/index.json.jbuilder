json.array!(@disks) do |disk|
  json.extract! disk, :id, :disk
  json.url disk_url(disk, format: :json)
end
