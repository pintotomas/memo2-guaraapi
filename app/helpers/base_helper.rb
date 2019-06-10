def valid_api_key?(key)
  return true if key == ENV['HTTP_API_TOKEN']

  false
end
