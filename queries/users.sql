-- name: CreateUser :exec
INSERT INTO users (first_name, last_name, username, email, password, avatar)
VALUES (?, ?, ?, ?, ?, ?);

-- name: GetUserByID :one
SELECT * FROM users WHERE id = ?;

-- name: UpdateUser :exec
UPDATE users
SET
    first_name = COALESCE(?, first_name),
    last_name = COALESCE(?, last_name),
    username = COALESCE(?, username),
    email = COALESCE(?, email),
    password = COALESCE(?, password),
    avatar = COALESCE(?, avatar),
    active = COALESCE(?, active),
    flag = COALESCE(?, flag)
WHERE id = ?
  AND (COALESCE(?, first_name) != first_name
         OR COALESCE(?, last_name) != last_name
         OR COALESCE(?, username) != username
         OR COALESCE(?, email) != email
         OR COALESCE(?, password) != password
         OR COALESCE(?, avatar) != avatar
         OR COALESCE(?, active) != active
         OR COALESCE(?, flag) != flag);

-- name: DeleteUser :exec
DELETE FROM users WHERE id = ?;
