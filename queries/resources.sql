
-- name: CreateResource :exec
INSERT INTO resources (id, name, code) VALUES (?, ?, ?);

-- name: GetResourceByID :one
SELECT * FROM resources WHERE id = ?;

-- name: UpdateResource :exec
UPDATE resources
SET
    name = COALESCE(?, name),
    code = COALESCE(?, code)
WHERE id = ?
  AND (COALESCE(?, name) != name
         OR COALESCE(?, code) != code);

-- name: DeleteResource :exec
DELETE FROM resources WHERE id = ?;
