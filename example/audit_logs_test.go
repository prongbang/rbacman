package main

import (
	"context"
	"github.com/jmoiron/sqlx"
	"github.com/prongbang/rbacman/pkg/db"
	"github.com/prongbang/rbacman/pkg/rbacman"
	"log"
	"log/slog"
	"testing"
)

func TestCreate(t *testing.T) {
	conn, err := sqlx.Connect("mysql", "root:password@tcp(127.0.0.1:3306)/mariaDB")
	if err != nil {
		log.Fatal(err)
	}
	queries := db.New(conn)
	ds := rbacman.NewDataSource(queries)
	ctx := context.Background()

	err = ds.CreateAuditLog(ctx, db.CreateAuditLogParams{
		UserID:   "f7e36835-ab2e-11ef-b686-0242ac110002",
		Action:   "CREATE",
		Resource: "USER",
	})
	slog.Error("create", "message", err)
}
