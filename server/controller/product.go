package controller

import (
	"eggsan/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

func (ct *Controller) GetAllProducts(c *gin.Context) {
	var res []models.Product
	query := `SELECT id, name, description, quantity, category, price, image_url from products `
	err := ct.storage.SelectContext(c, &res, query)
	if err != nil {
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}
	if res == nil {
		res = []models.Product{}
	}
	c.JSON(http.StatusOK, res)
}

func (ct *Controller) DeleteProductByID(c *gin.Context) {
	id := c.Param("id")
	query := `DELETE FROM products WHERE id = $1`
	_, err := ct.storage.ExecContext(c, query, id)
	if err != nil {
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Product deleted successfully"})
}

func (ct *Controller) UpdateProductByID(c *gin.Context) {
	id := c.Param("id")

	var input models.Product
	if err := c.BindJSON(&input); err != nil {
		newErrorResponse(c, http.StatusBadRequest, "Invalid JSON")
		return
	}

	query := `
		UPDATE products
		SET name = $1, description = $2, quantity = $3, category = $4, price = $5, image_url = $6
		WHERE id = $7
	`
	_, err := ct.storage.ExecContext(c, query, input.Name, input.Description, input.Quantity, input.Category, input.Price, input.ImageURL, id)
	if err != nil {
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, gin.H{"message": "Product updated successfully"})
}

func (ct *Controller) GetProductByID(c *gin.Context) {
	id := c.Param("id")
	var res models.Product

	query := `SELECT id, name, description, quantity, category, price, image_url FROM products WHERE id = $1`
	err := ct.storage.GetContext(c, &res, query, id)
	if err != nil {
		newErrorResponse(c, http.StatusNotFound, "Product not found")
		return
	}

	c.JSON(http.StatusOK, res)
}

func (ct *Controller) AddProduct(c *gin.Context) {
	var input models.Product

	if err := c.BindJSON(&input); err != nil {
		newErrorResponse(c, http.StatusBadRequest, "Invalid JSON")
		return
	}

	query := `
		INSERT INTO products (name, description, quantity, category, price, image_url)
		VALUES ($1, $2, $3, $4, $5, $6)
		RETURNING id
	`

	var newID int
	err := ct.storage.QueryRowContext(c, query, input.Name, input.Description, input.Quantity, input.Category, input.Price, input.ImageURL).Scan(&newID)
	if err != nil {
		newErrorResponse(c, http.StatusInternalServerError, err.Error())
		return
	}
	c.JSON(http.StatusOK, gin.H{
		"id": newID,
	})
}
