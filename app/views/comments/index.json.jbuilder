json.array! @comments do |comment|
  json.id comment.id
  json.author comment.nombre
  json.comment comment.contenido
  json.entry_id comment.entry_id
end
