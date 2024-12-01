-- name: CreateGroupPermission :exec
INSERT INTO `groups_permissions` (group_id, resource_id, permission_id)
VALUES (?, ?, ?);

-- name: GetGroupPermissionsByGroupID :many
SELECT * FROM `groups_permissions` WHERE group_id = ?;

-- name: UpdateGroupPermission :exec
UPDATE groups_permissions
SET
    group_id = COALESCE(?, group_id),
    resource_id = COALESCE(?, resource_id),
    permission_id = COALESCE(?, permission_id)
WHERE id = ?
  AND (COALESCE(?, group_id) != group_id
         OR COALESCE(?, resource_id) != resource_id
         OR COALESCE(?, permission_id) != permission_id);

-- name: DeleteGroupPermission :exec
DELETE FROM `groups_permissions`
WHERE group_id = ? AND resource_id = ? AND permission_id = ?;