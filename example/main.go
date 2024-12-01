package main

import (
	"context"
	"fmt"
	"github.com/prongbang/rbacman/internal/db"
	"github.com/prongbang/rbacman/internal/rbacman"
	"log"

	_ "github.com/go-sql-driver/mysql"
	"github.com/jmoiron/sqlx"
)

func main() {
	conn, err := sqlx.Connect("mysql", "root:password@tcp(127.0.0.1:3306)/mariaDB")
	if err != nil {
		log.Fatal(err)
	}
	queries := db.New(conn)

	ds := rbacman.NewDataSource(queries)

	ctx := context.Background()
	permission := ds.CheckPermissionsByUserID(ctx, rbacman.CheckPermissionsUserIDParams{
		ID:   "1",
		Code: rbacman.PermissionCode(rbacman.ResourceRole, rbacman.PermissionRead),
	})

	fmt.Println("permission:", permission)
}
