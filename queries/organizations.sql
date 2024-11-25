
-- name: CreateOrganization :exec
INSERT INTO organizations (id, name, parent_id) VALUES ($1, $2, $3);

-- name: GetOrganizationByID :one
SELECT * FROM organizations WHERE id = $1;

-- name: UpdateOrganization :exec
UPDATE organizations
SET
    name = COALESCE($2, name),
    parent_id = COALESCE($3, parent_id)
WHERE id = $1
  AND (COALESCE($2, name) != name
         OR COALESCE($3, parent_id) != parent_id);

-- name: DeleteOrganization :exec
DELETE FROM organizations WHERE id = $1;
