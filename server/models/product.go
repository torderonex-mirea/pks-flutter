package models

type Product struct {
	ID          int    `json:"id" db:"id"`
	Description string `json:"description" db:"description"`
	Quantity    int    `json:"quantity" db:"quantity"`
	Category    string `json:"category" db:"category"`
	Name        string `json:"name" db:"name"`
	Price       int    `json:"price" db:"price"`
	ImageURL    string `json:"image_url" db:"image_url"`
}
