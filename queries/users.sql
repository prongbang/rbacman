-- name: CreateUser :exec
INSERT INTO users (first_name, last_name, username, email, password, avatar)
VALUES ($1, $2, $3, $4, $5, $6);

-- name: GetUserByID :one
SELECT * FROM users WHERE id = $1;

-- name: UpdateUser :exec
UPDATE users
SET
    first_name = COALESCE($2, first_name),
    last_name = COALESCE($3, last_name),
    username = COALESCE($4, username),
    email = COALESCE($5, email),
    password = COALESCE($6, password),
    avatar = COALESCE($7, avatar),
    active = COALESCE($8, active),
    flag = COALESCE($9, flag)
WHERE id = $1
  AND (COALESCE($2, first_name) != first_name
         OR COALESCE($3, last_name) != last_name
         OR COALESCE($4, username) != username
         OR COALESCE($5, email) != email
         OR COALESCE($6, password) != password
         OR COALESCE($7, avatar) != avatar
         OR COALESCE($8, active) != active
         OR COALESCE($9, flag) != flag);

-- name: DeleteUser :exec
DELETE FROM users WHERE id = $1;
