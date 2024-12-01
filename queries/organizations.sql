
-- name: CreateOrganization :exec
INSERT INTO organizations (id, name, parent_id) VALUES (?, ?, ?);

-- name: GetOrganizationByID :one
SELECT * FROM organizations WHERE id = ?;

-- name: UpdateOrganization :exec
UPDATE organizations
SET
    name = COALESCE(?, name),
    parent_id = COALESCE(?, parent_id)
WHERE id = ?
  AND (COALESCE(?, name) != name
         OR COALESCE(?, parent_id) != parent_id);

-- name: DeleteOrganization :exec
DELETE FROM organizations WHERE id = ?;
