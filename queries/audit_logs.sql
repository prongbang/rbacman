
-- name: CreateAuditLog :exec
INSERT INTO audit_logs (id, user_id, action, resource) VALUES ($1, $2, $3, $4);

-- name: UpdateAuditLog :exec
UPDATE audit_logs
SET
    user_id = COALESCE($2, user_id),
    action = COALESCE($3, action),
    resource = COALESCE($4, resource),
    timestamp = COALESCE($5, timestamp)
WHERE id = $1
  AND (COALESCE($2, user_id) != user_id
         OR COALESCE($3, action) != action
         OR COALESCE($4, resource) != resource
         OR COALESCE($5, timestamp) != timestamp);

-- name: GetAuditLogsByUserID :many
SELECT * FROM audit_logs WHERE user_id = $1;

-- name: GetAllAuditLogs :many
SELECT * FROM audit_logs;