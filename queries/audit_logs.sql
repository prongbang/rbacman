
-- name: CreateAuditLog :exec
INSERT INTO audit_logs (id, user_id, action, resource) VALUES (?, ?, ?, ?);

-- name: UpdateAuditLog :exec
UPDATE audit_logs
SET
    user_id = COALESCE(?, user_id),
    action = COALESCE(?, action),
    resource = COALESCE(?, resource),
    timestamp = COALESCE(?, timestamp)
WHERE id = ?
  AND (COALESCE(?, user_id) != user_id
         OR COALESCE(?, action) != action
         OR COALESCE(?, resource) != resource
         OR COALESCE(?, timestamp) != timestamp);

-- name: GetAuditLogsByUserID :many
SELECT * FROM audit_logs WHERE user_id = ?;

-- name: GetAllAuditLogs :many
SELECT * FROM audit_logs;