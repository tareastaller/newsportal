json.array! @entries do |entry|
  json.id entry.id
  json.title entry.titular
  json.subtitle entry.bajada
  json.body entry.cuerpo
end
