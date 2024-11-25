-- name: CreateGroupPermission :exec
INSERT INTO `groups_permissions` (group_id, resource_id, permission_id)
VALUES ($1, $2, $3);

-- name: GetGroupPermissionsByGroupID :many
SELECT * FROM `groups_permissions` WHERE group_id = $1;

-- name: UpdateGroupPermission :exec
UPDATE groups_permissions
SET
    group_id = COALESCE($2, group_id),
    resource_id = COALESCE($3, resource_id),
    permission_id = COALESCE($4, permission_id)
WHERE id = $1
  AND (COALESCE($2, group_id) != group_id
         OR COALESCE($3, resource_id) != resource_id
         OR COALESCE($4, permission_id) != permission_id);

-- name: DeleteGroupPermission :exec
DELETE FROM `groups_permissions`
WHERE group_id = $1 AND resource_id = $2 AND permission_id = $3;