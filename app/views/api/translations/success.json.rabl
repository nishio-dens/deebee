object false

node(:status) { "success" }
child(@translation) do
  attributes :id, :ja, :en
  attribute created_at: :createdAt, updated_at: :updatedAt,
    creator_name: :creatorName, updater_name: :updaterName
end
