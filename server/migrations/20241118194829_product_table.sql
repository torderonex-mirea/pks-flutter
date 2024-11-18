-- +goose Up
-- +goose StatementBegin
CREATE TABLE users (
                       id SERIAL PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       image TEXT,
                       phone VARCHAR(50),
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
                          id SERIAL PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          description TEXT NOT NULL,
                          quantity INT,
                          category VARCHAR(100),
                          price INT NOT NULL,
                          image_url VARCHAR(255)
);

CREATE TABLE favorites (
                           id SERIAL PRIMARY KEY,
                           user_id INT REFERENCES users(id) ON DELETE CASCADE,
                           product_id INT REFERENCES products(id) ON DELETE CASCADE,
                           added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                           UNIQUE (user_id, product_id)
);

CREATE TABLE cart (
                      id SERIAL PRIMARY KEY,
                      user_id INT REFERENCES users(id) ON DELETE CASCADE,
                      product_id INT REFERENCES products(id) ON DELETE CASCADE,
                      quantity INT DEFAULT 1,
                      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                      UNIQUE (user_id, product_id)
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS cart;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;
-- +goose StatementEnd
