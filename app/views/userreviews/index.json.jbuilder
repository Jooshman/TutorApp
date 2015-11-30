json.array!(@userreviews) do |userreview|
  json.extract! userreview, :id, :name, :body, :userlogin_id
  json.url userreview_url(userreview, format: :json)
end
