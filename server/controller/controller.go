package controller

import (
	"github.com/jmoiron/sqlx"
)

type Controller struct {
	storage *sqlx.DB
}

func New(db *sqlx.DB) *Controller {
	return &Controller{storage: db}
}
