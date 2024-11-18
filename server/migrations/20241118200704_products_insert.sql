-- +goose Up
-- +goose StatementBegin
INSERT INTO products (id, name, description, quantity, category, price, image_url) VALUES
(1, 'IPHONE 15 PRO MAX 1TB', 'Очень хороший телефон', 10, 'Телефоны', 1000, 'https://img.mvideo.ru/Big/30074465bb.jpg'),
(2, 'SAMSUNG S11 PRO 512GB', 'Очень плохой телефон', 1, 'Телефоны', 600, 'https://img.mvideo.ru/Big/30070136bb.jpg'),
(3, 'Телевизор Philips 50PUS8507/60', 'Телевизор Philips 50PUS8507/60', 100, 'Телевизоры', 2100, 'https://img.mvideo.ru/Big/10031891bb.jpg'),
(4, 'Стиральная машина HAUSWIRT S 6102', 'Стиральная машина HAUSWIRT S 6102', 100, 'Стиральные машины', 2100, 'https://www.belaya-tehnika.ru/images/watermarked/1/detailed/9/%D0%A1%D1%82%D0%B8%D1%80%D0%B0%D0%BB%D1%8C%D0%BD%D0%B0%D1%8F_%D0%BC%D0%B0%D1%88%D0%B8%D0%BD%D0%B0_HAUSWIRT_S_6102.jpg'),
(5, 'Apple MacBook Pro 16', 'Ноутбук Apple MacBook Pro 16', 50, 'Ноутбуки', 3000, 'https://m.media-amazon.com/images/I/61aUBxqc5PL._AC_UF1000,1000_QL80_.jpg'),
(6, 'Sony PlayStation 5', 'Игровая приставка Sony PlayStation 5', 200, 'Игровые приставки', 500, 'https://cdn.idealo.com/folder/Product/200584/7/200584783/s1_produktbild_max/sony-playstation-5-ps5-standard-edition.jpg'),
(7, 'Apple Watch Series 7', 'Умные часы Apple Watch Series 7', 150, 'Умные часы', 400, 'https://appleshops.ru/image/cache/catalog/Apple/Apple%20Watch%20Series%207%2041/147184_p_27-500x500.png_500.webp'),
(8, 'Samsung Galaxy Tab S7', 'Планшет Samsung Galaxy Tab S7', 80, 'Планшеты', 700, 'https://static.galaxystore.ru/upload/resize_cache/iblock/039/440_440_1/0390c8a30d4bffa85941f9cfe116ae9e.jpg'),
(9, 'Xiaomi Mi Band 6', 'Фитнес-браслет Xiaomi Mi Band 6', 300, 'Умные часы', 50, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQSYFs507g38XAQ-WbEZOQ1k4er1x42m4STvw&s'),
(10, 'Amazon Kindle Paperwhite', 'Электронная книга Amazon Kindle Paperwhite', 120, 'Электронные книги', 150, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYCfFiFnSAqtHxp8fjQFIQNKsgDa6p25etRQ&s');

-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DELETE FROM products;
-- +goose StatementEnd
