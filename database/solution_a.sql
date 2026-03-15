USE ql_bke;
select * from users;

-- Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z)
select * from users order by user_id ASC;

-- Lấy ra 07 người dùng theo thứ tự tên theo Alphabet (A->Z)
select * from users order by user_id ASC limit 7;

-- Lấy ra danh sách người dùng theo thứ tự tên theo Alphabet (A->Z), trong đó tên người dùng có chữ a
select * from users where user_id like '%a%' order by user_id ASC;

-- Lấy ra danh sách người dùng trong đó tên người dùng bắt đầu bằng chữ m
select * from users where user_id like 'm%';

-- Lấy ra danh sách người dùng trong đó tên người dùng kết thúc bằng chữ i
select * from users where user_id like '%i';

-- Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ: example@gmail.com)
select * from users where user_email like '%@gmail.com';

-- Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ: example@gmail.com), tên người dùng bắt đầu bằng chữ m
select * from users where user_email like 'm%@gmail.com';

-- Lấy ra danh sách người dùng trong đó email người dùng là Gmail (ví dụ: example@gmail.com), tên người dùng có chữ i và tên người dùng có chiều dài lớn hơn 5
select * from users where user_email like '%@gmail.com' AND user_id = '%i%' AND length(user_id) > 5;

-- Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5 đến 9, email dùng dịch vụ Gmail, trong tên email có chữ I (trong tên, chứ không phải domain exampleitest@yahoo.com)
select * from users where user_id LIKE '%a%'
AND LENGTH(user_id) BETWEEN 5 AND 9
AND user_email LIKE '%@gmail.com'
AND user_email LIKE '%i%@gmail.com';

-- Lấy ra danh sách người dùng trong đó tên người dùng có chữ a, chiều dài từ 5 đến 9 hoặc tên người dùng có chữ i, chiều dài nhỏ hơn 9 hoặc email dùng dịch vụ Gmail, trong tên email có chữ
select * from users 
where (user_id LIKE '%a%' AND LENGTH(user_id) BETWEEN 5 AND 9)
   OR (user_id LIKE '%i%' AND LENGTH(user_id) < 9)
   OR (user_email LIKE '%i%@gmail.com');




