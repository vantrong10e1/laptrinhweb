USE ql_bke;
select * from users;

-- Liệt kê các hóa đơn của khách hàng, thông tin hiển thị gồm: mã user, tên user, mã hóa đơn
SELECT users.user_id, users.user_name, orders.order_id
FROM users
JOIN orders ON users.user_id = orders.user_id;

-- Liệt kê số lượng các hóa đơn của khách hàng: mã user, tên user, số đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS so_don_hang
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name;

-- Liệt kê thông tin hóa đơn: mã đơn hàng, số sản phẩm
SELECT order_id, COUNT(product_id) AS so_san_pham
FROM order_details
GROUP BY order_id;

-- Liệt kê thông tin mua hàng của người dùng: mã user, tên user, mã đơn hàng, tên sản phẩm. Lưu ý: gôm nhóm theo đơn hàng, tránh hiển thị xen kẻ các đơn hàng với nhau
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
ORDER BY o.order_id;

-- Liệt kê 7 người dùng có số lượng đơn hàng nhiều nhất, thông tin hiển thị gồm: mã user, tên user, số lượng đơn hàng
SELECT u.user_id, u.user_name, COUNT(o.order_id) AS so_don_hang
FROM users u
JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.user_name
ORDER BY so_don_hang DESC
LIMIT 7;

-- Liệt kê 7 người dùng mua sản phẩm có tên: Samsung hoặc Apple trong tên sản phẩm, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tên sản phẩm
SELECT u.user_id, u.user_name, o.order_id, p.product_name
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
WHERE p.product_name LIKE '%Samsung%'
   OR p.product_name LIKE '%Apple%'
LIMIT 7;

-- Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền
SELECT u.user_id, u.user_name, o.order_id,
       SUM(p.product_price) AS tong_tien
FROM users u
JOIN orders o ON u.user_id = o.user_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY u.user_id, u.user_name, o.order_id;

-- Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền lớn nhất.
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
           SUM(p.product_price) AS tong_tien,
           ROW_NUMBER() OVER (
               PARTITION BY u.user_id
               ORDER BY SUM(p.product_price) DESC
           ) AS rn
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE rn = 1;

-- hàng có giá tiền lớn nhất. 9. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ chọn ra 1 đơn hàng có giá tiền nhỏ nhất.
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
           SUM(p.product_price) AS tong_tien,
           COUNT(od.product_id) AS so_san_pham,
           ROW_NUMBER() OVER (
               PARTITION BY u.user_id
               ORDER BY SUM(p.product_price) ASC
           ) AS rn
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE rn = 1;

-- chọn ra 1 đơn hàng có giá tiền nhỏ nhất. 10. Liệt kê danh sách mua hàng của user bao gồm giá tiền của mỗi đơn hàng, thông tin hiển thị gồm: mã user, tên user, mã đơn hàng, tổng tiền, số sản phẩm. Mỗi user chỉ chọn ra 1 đơn hàng có số sản phẩm là nhiều nhất.
SELECT *
FROM (
    SELECT u.user_id, u.user_name, o.order_id,
           SUM(p.product_price) AS tong_tien,
           COUNT(od.product_id) AS so_san_pham,
           ROW_NUMBER() OVER (
               PARTITION BY u.user_id
               ORDER BY COUNT(od.product_id) DESC
           ) AS rn
    FROM users u
    JOIN orders o ON u.user_id = o.user_id
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY u.user_id, u.user_name, o.order_id
) t
WHERE rn = 1;




