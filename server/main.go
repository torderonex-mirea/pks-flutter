package main

import (
	"eggsan/controller"
	"fmt"
	"github.com/gin-gonic/gin"
	"github.com/jmoiron/sqlx"
	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
	"log"
	"os"
)

func init() {
	if err := godotenv.Load("config/.env"); err != nil {
		log.Fatalf("Error loading .env file: %v", err)
	}
}

func main() {
	storage := newDBConnection()
	c := controller.New(storage)

	router := gin.New()
	router.Use(gin.Logger())

	products := router.Group("/products")
	{
		products.GET("/", c.GetAllProducts)
		products.GET("/:id", c.GetProductByID)
		products.DELETE("/:id", c.DeleteProductByID)
		products.PUT("/:id", c.UpdateProductByID)
		products.POST("/", c.AddProduct)
	}
	log.Fatal(router.Run(":6969"))
}

func newDBConnection() *sqlx.DB {
	var db *sqlx.DB

	db, err := sqlx.Connect("postgres", fmt.Sprintf("postgres://%s:%s@%s:%d/%s?sslmode=%s",
		os.Getenv("PG_USR"), os.Getenv("PG_PWD"), os.Getenv("PG_HOST"), 5432, "eggsan", "disable"))

	if err != nil {
		panic(err.Error())
	}

	return db
}
