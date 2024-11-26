/* 스키마 db_bookstore 를 생성하고 이 스키마를 사용하시오. */

DROP DATABASE IF EXISTS db_bookstore;

CREATE DATABASE IF NOT EXISTS db_bookstore;

USE db_bookstore;

DROP TABLE IF EXISTS tbl_order;
DROP TABLE IF EXISTS tbl_customer;
DROP TABLE IF EXISTS tbl_book;

-- 1. tbl_book 테이블을 생성하시오.
/*
    tbl_book 테이블
    (1) book_id   : 책번호, 정수, AUTO_INCREMENT, 필수, PK
    (2) book_name : 책이름, 가변 길이 문자 (최대 100)
    (3) publisher : 출판사, 가변 길이 문자 (최대 50)
    (4) price     : 가격, 정수
*/
CREATE TABLE IF NOT EXISTS tbl_book
(
    book_id INT AUTO_INCREMENT NOT NULL COMMENT '책번호',
    book_name VARCHAR(100) COMMENT '책이름',
    publisher VARCHAR(50) COMMENT '출판사',
    price INT COMMENT '가격',
    CONSTRAINT pk_book PRIMARY KEY(book_id)
)ENGINE=INNODB COMMENT '책테이블';


-- 2. tbl_customer 테이블을 생성하시오.
/*
    tbl_customer 테이블
    (1) cust_id   : 고객번호, 정수, AUTO_INCREMENT, 필수, PK
    (2) cust_name : 고객명, 가변 길이 문자 (최대 20)
    (3) cust_addr : 주소, 가변 길이 문자 (최대 50)
    (4) cust_tel  : 전화, 가변 길이 문자 (최대 20)
*/
CREATE TABLE IF NOT EXISTS tbl_customer
(
    cust_id INT AUTO_INCREMENT NOT NULL COMMENT '고객번호',
    cust_name VARCHAR(20) COMMENT '고객명',
    cust_addr VARCHAR(50) COMMENT '주소',
    cust_tel VARCHAR(20) COMMENT '전화',
    CONSTRAINT pk_customer PRIMARY KEY(cust_id)
)ENGINE=INNODB COMMENT '고객테이블';


-- 3. tbl_order 테이블을 생성하시오.
/*
    tbl_order 테이블
    (1) order_id   : 주문번호, 정수, AUTO_INCREMENT, 필수, PK
    (2) cust_id    : 고객번호, 정수, FK (tbl_customer의 cust_id 칼럼을 참조. 고객 정보가 삭제되면 NULL 값으로 변경_SET NULL)
    (3) book_id    : 책번호, 정수, FK (tbl_book의 book_id 칼럼을 참조. 책 정보가 삭제되면 함께 삭제_CASCADE)
    (4) amount     : 판매수량, 정수
    (5) ordered_at : 주문일, 날짜
*/
CREATE TABLE IF NOT EXISTS tbl_order
(
    order_id INT AUTO_INCREMENT NOT NULL COMMENT '주문번호',
    cust_id INT COMMENT '고객번호',
    book_id INT COMMENT '책번호',
    amount INT COMMENT '판매수량',
    ordered_at DATE COMMENT '주문일',
    CONSTRAINT pk_order PRIMARY KEY(order_id),
    CONSTRAINT fk_customer_order FOREIGN KEY(cust_id) REFERENCES tbl_customer(cust_id) ON DELETE SET NULL,
    CONSTRAINT fk_book_order FOREIGN KEY(book_id) REFERENCES tbl_book(book_id) ON DELETE RESTRICT
)ENGINE=INNODB COMMENT '주문테이블';


-- 4. 아래 데이터를 tbl_book 테이블에 INSERT 하시오.
/*
    책번호  책이름           출판사      가격
    1       축구의 역사      굿스포츠    7000
    2       축구 아는 여자   나이스북    13000
    3       축구의 이해      대한미디어  22000
    4       골프 바이블      대한미디어  35000
    5       피겨 교본        굿스포츠    6000
    6       역도 단계별 기술 굿스포츠    6000
    7       야구의 추억      이상미디어  20000
    8       야구를 부탁해    이상미디어  13000
    9       올림픽 이야기    삼성당      7500
    10      올림픽 챔피언    나이스북    13000
*/
INSERT INTO tbl_book VALUES(NULL, '축구의 역사', '굿스포츠', 7000);
INSERT INTO tbl_book VALUES(NULL, '축구 아는 여자', '나이스북', 13000);
INSERT INTO tbl_book VALUES(NULL, '축구의 이해', '대한미디어', 22000);
INSERT INTO tbl_book VALUES(NULL, '골프 바이블', '대한미디어', 35000);
INSERT INTO tbl_book VALUES(NULL, '피겨 교본', '굿스포츠', 6000);
INSERT INTO tbl_book VALUES(NULL, '역도 단계별 기술', '굿스포츠', 6000);
INSERT INTO tbl_book VALUES(NULL, '야구의 추억', '이상미디어', 20000);
INSERT INTO tbl_book VALUES(NULL, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO tbl_book VALUES(NULL, '올림픽 이야기', '삼성당', 7500);
INSERT INTO tbl_book VALUES(NULL, '올림픽 챔피언', '나이스북', 13000);



-- 5. 아래 데이터를 tbl_customer 테이블에 INSERT 하시오.
/*
    회원번호 고객명   주소      전화
    1000     박지성   영국      000-000-0000
    1001     김연아   대한민국  111-111-1111
    1002     장미란   대한민국  222-222-2222
    1003     추신수   미국      333-333-3333
    1004     박세리   대한민국  NULL
*/
ALTER TABLE tbl_customer AUTO_INCREMENT = 1000;

INSERT INTO tbl_customer VALUES(NULL, '박지성', '영국', '000-000-0000');
INSERT INTO tbl_customer VALUES(NULL, '김연아', '대한민국', '111-111-1111');
INSERT INTO tbl_customer VALUES(NULL, '장미란', '대한민국', '222-222-2222');
INSERT INTO tbl_customer VALUES(NULL, '추신수', '미국', '333-333-3333');
INSERT INTO tbl_customer VALUES(NULL, '박세리', '대한민국', NULL);


-- 6. 아래 데이터를 tbl_order 테이블에 INSERT 하시오.
/*
    주문번호   고객번호  책번호  판매수량 주문일자
    1          1000      1       1        2020-07-01
    2          1000      3       2        2020-07-03
    3          1001      5       1        2020-07-03
    4          1002      6       2        2020-07-04
    5          1003      7       3        2020-07-05
    6          1000      2       5        2020-07-07
    7          1003      8       2        2020-07-07
    8          1002      10      2        2020-07-08
    9          1001      10      1        2020-07-09
    10         1002      6       4        2020-07-10
*/
INSERT INTO tbl_order VALUES(NULL, 1000, 1, 1, '2020-07-01');
INSERT INTO tbl_order VALUES(NULL, 1000, 3, 2, '2020-07-03');
INSERT INTO tbl_order VALUES(NULL, 1001, 5, 1, '2020-07-03');
INSERT INTO tbl_order VALUES(NULL, 1002, 6, 2, '2020-07-04');
INSERT INTO tbl_order VALUES(NULL, 1003, 7, 3, '2020-07-05');
INSERT INTO tbl_order VALUES(NULL, 1000, 2, 5, '2020-07-07');
INSERT INTO tbl_order VALUES(NULL, 1003, 8, 2, '2020-07-07');
INSERT INTO tbl_order VALUES(NULL, 1002, 10, 2, '2020-07-08');
INSERT INTO tbl_order VALUES(NULL, 1001, 10, 1, '2020-07-09');
INSERT INTO tbl_order VALUES(NULL, 1002, 6, 4, '2020-07-10');


-- 7. 책이름에 올림픽이 포함된 책 정보를 조회하시오.
-- book_id  book_name      publisher  price
-- 9        올림픽 이야기  삼성당     7500
-- 10       올림픽 챔피언  나이스북   13000
SELECT book_id, book_name, publisher, price
  FROM tbl_book
 WHERE book_name LIKE CONCAT('%','올림픽','%');


-- 8. 가격이 가장 비싼 책을 조회하시오.
-- book_id  book_name    publisher    price
-- 4        골프 바이블  대한미디어   35000
SELECT book_id, book_name, publisher, price
  FROM tbl_book
 ORDER BY price DESC -- 비싼 책 순서로 내림차순
 LIMIT 0,1;


-- 9. 2020-07-05부터 2020-07-09 사이에 주문된 도서 정보를 조회하시오.
-- 주문번호 책번호 책이름
-- 5        7      야구의 추억
-- 6        2      축구 아는 여자
-- 7        8      야구를 부탁해
-- 8        10     올림픽 챔피언
-- 9        10     올림픽 챔피언
SELECT order_id, o.book_id, book_name
  FROM tbl_book b INNER JOIN tbl_order o
    ON b.book_id = o.book_id
 WHERE ordered_at BETWEEN '2020-07-05' AND '2020-07-09';


-- 10. 주문한 이력이 없는 고객의 이름을 조회하시오.
-- 고객명
-- 박세리
-- 1.
SELECT cust_name
  FROM tbl_customer
 WHERE cust_id NOT IN(SELECT cust_id FROM tbl_order);
 
-- 2.
SELECT c.cust_name
  FROM tbl_customer c LEFT JOIN tbl_order o
    ON c.cust_id = o.cust_id
 WHERE o.order_id IS NULL;


-- 11. 2020-07-04부터 2020-07-07 사이에 주문 받은 도서를 제외하고 나머지 모든 주문 정보를 조회하시오.
-- 구매번호  구매자  책이름           총구매액 주문일자
-- 1         박지성  축구의 역사      7000     2020-07-01
-- 2         박지성  축구의 이해      44000    2020-07-03
-- 3         김연아  피겨 교본        6000     2020-07-03
-- 8         장미란  올림픽 챔피언    26000    2020-07-08
-- 9         김연아  올림픽 챔피언    13000    2020-07-09
-- 10        장미란  역도 단계별 기술 24000    2020-07-10
SELECT o.order_id
     , c.cust_name
     , b.book_name
     , b.price * o.amount
     , o.ordered_at
  FROM tbl_book b INNER JOIN tbl_order o
    ON b.book_id = o.book_id INNER JOIN tbl_customer c
    ON c.cust_id = o.cust_id
 WHERE o.ordered_at NOT BETWEEN '2020-07-04' AND '2020-07-07';


-- 12. 가장 최근에 구매한 고객의 이름, 책이름, 주문일자를 조회하시오.
-- 고객명  책이름            주문일자
-- 장미란  역도 단계별 기술  2020-07-10
SELECT c.cust_name, b.book_name, o.ordered_at
  FROM tbl_book b INNER JOIN tbl_order o -- INNER JOIN : '가장 최근에 구매한' > 책 테이블과 주문 테이블에 모두 있는 데이터 반환
    ON b.book_id = o.book_id INNER JOIN tbl_customer c
    ON o.cust_id = c.cust_id
 WHERE o.ordered_at = (SELECT MAX(ordered_at) FROM tbl_order);  -- 주문 날짜의 최대값 (가장 최근 값)
  

-- 13. 주문된 적이 없는 책의 주문번호, 책번호, 책이름을 조회하시오.
-- 주문번호 책번호 책이름
-- NULL     4      골프 바이블
-- NULL     9      올림픽 이야기
SELECT o.order_id, b.book_id, b.book_name
  FROM tbl_book b LEFT JOIN tbl_order o -- LEFT JOIN : '주문된 적이 없는' > 책 테이블에는 있고, 주문 테이블에는 없는 데이터 반환
    ON b.book_id = o.book_id
 WHERE o.order_id IS NULL;


-- 14. 모든 서적 중에서 가장 비싼 서적을 구매한 고객이름, 책이름, 가격을 조회하시오.
-- 가장 비싼 서적을 구매한 고객이 없다면 고객 이름은 NULL로 처리하시오.
-- 고객명  책이름       책가격
-- NULL    골프 바이블  35000
SELECT c.cust_name, b.book_name, b.price
  FROM tbl_book b LEFT JOIN tbl_order o
    ON b.book_id = o.book_id LEFT JOIN tbl_customer c
    ON c.cust_id = o.cust_Id
 WHERE b.price = (SELECT MAX(price) FROM tbl_book);


-- 15. 김연아가 구매한 도서수를 조회하시오.
-- 고객명  구매도서수
-- 김연아  2
SELECT c.cust_name, COUNT(o.order_id)
  FROM tbl_customer c LEFT JOIN tbl_order o
    ON c.cust_id = o.cust_id
 WHERE c.cust_name = '김연아'
 GROUP BY c.cust_id, c.cust_name;


-- 16. 출판사별로 판매된 책의 개수를 조회하시오.
-- 출판사     판매된책수
-- 굿스포츠   4
-- 삼성당     0
-- 나이스북   3
-- 대한미디어 1
-- 이상미디어 2
SELECT b.publisher, COUNT(o.order_id)
  FROM tbl_book b LEFT JOIN tbl_order o
    ON b.book_id = o.book_id
 GROUP BY b.publisher;


-- 17. 박지성이 구매한 도서를 발간한 출판사(publisher) 개수를 조회하시오.
-- 고객명  출판사수
-- 박지성  3
SELECT c.cust_name, COUNT(DISTINCT b.publisher)
  FROM tbl_customer c INNER JOIN tbl_order o
    ON c.cust_id = o.cust_id INNER JOIN tbl_book b
    ON b.book_id = o.book_id
 WHERE c.cust_name = '박지성'
 GROUP BY c.cust_id, c.cust_name;
 

-- 18. 모든 구매 고객의 이름과 총구매액(price * amount)을 조회하시오. 구매 이력이 있는 고객만 조회하시오.
-- 고객명  총구매액
-- 박지성  116000
-- 김연아  19000
-- 장미란  62000
-- 추신수  86000
SELECT c.cust_name, SUM(b.price * o.amount)
  FROM tbl_customer c INNER JOIN tbl_order o -- LEFT JOIN 시, 구매이력 x 고객까지 모두 노출됨 (customer 테이블 데이터 모두 출력)
    ON c.cust_id = o.cust_id INNER JOIN tbl_book b
    ON o.book_id = b.book_id
 GROUP BY c.cust_id, c.cust_name;


-- 19. 모든 구매 고객의 이름과 총구매액(price * amount)과 구매횟수를 조회하시오. 구매 이력이 없는 고객은 총구매액과 구매횟수를 0으로 조회하고, 고객번호 오름차순으로 정렬하시오.
-- 고객명  총구매액  구매횟수
-- 박지성  116000     3
-- 김연아  19000      2
-- 장미란  62000      3
-- 추신수  86000      2
-- 박세리  0          0
SELECT c.cust_name
     , IFNULL(SUM(b.price * o.amount),0)
     , COUNT(o.order_id)
  FROM tbl_customer c LEFT JOIN tbl_order o
    ON c.cust_id = o.cust_id LEFT JOIN tbl_book b
    ON o.book_id = b.book_id
 GROUP BY c.cust_id, c.cust_name
 ORDER BY c.cust_id ASC;


-- 20. 총구매액이 2~3위인 고객의 이름와 총구매액을 조회하시오.
-- 고객명  총구매액
-- 추신수  86000
-- 장미란  62000
SELECT c.cust_name AS 고객명, SUM(b.price * o.amount) AS 총구매액
  FROM tbl_customer c LEFT JOIN tbl_order o
    ON c.cust_id = o.cust_id LEFT JOIN tbl_book b
    ON o.book_id = b.book_id
 GROUP BY c.cust_name, c.cust_id
 ORDER BY 총구매액 DESC
 LIMIT 1,2;  -- 인덱스 0번부터 시작 > 두번째 인덱스(1번)부터 2개 보여달라.
