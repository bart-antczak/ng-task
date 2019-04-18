json.array! @movies do |movie|
  json.id movie.id
  json.title movie.title
  json.genre movie.genre_id
end