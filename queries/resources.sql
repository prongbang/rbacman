
-- name: CreateResource :exec
INSERT INTO resources (id, name, code) VALUES ($1, $2, $3);

-- name: GetResourceByID :one
SELECT * FROM resources WHERE id = $1;

-- name: UpdateResource :exec
UPDATE resources
SET
    name = COALESCE($2, name),
    code = COALESCE($3, code)
WHERE id = $1
  AND (COALESCE($2, name) != name
         OR COALESCE($3, code) != code);

-- name: DeleteResource :exec
DELETE FROM resources WHERE id = $1;
