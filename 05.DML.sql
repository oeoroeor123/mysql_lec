USE db_company;

-- 1001부터 자동 순번 증가
ALTER TABLE tbl_employee AUTO_INCREMENT = 1001;

-- 행 삽입하기 (INSERT)

-- 단일 행 삽입
-- INSERT INTO 테이블명(칼럼1, 칼럼2, ...) VALUES(값1, 값2, ...);
-- 어떤 테이블의 어떤 칼럼(AUTO_INCREMENT는 자동 생성이니 제외)을 가져올지, 칼럼에 어떤 내용을 넣을지 한줄씩 작성

-- 다중 행 삽입
-- INSERT INTO 테이블명(칼럼1, 칼럼2, ...) VALUES(값1, 값2, ...),(값1, 값2, ...);

INSERT INTO tbl_department(dept_name, location) VALUES('영업부', '대구');
INSERT INTO tbl_department(dept_name, location) VALUES('인사부', '서울');
INSERT INTO tbl_department(dept_name, location) VALUES('총무부', '대구');
INSERT INTO tbl_department(dept_name, location) VALUES('기획부', '서울');

-- tbl_employee의 첫 번째 칼럼 emp_id에는 NULL 값을 전달해서 emp_id의 AUTO_INCREMENT 동작을 보장한다.
INSERT INTO tbl_employee VALUES(NULL, 1, '구창민', '과장', 'M', '95-05-01', '5000000');
INSERT INTO tbl_employee VALUES(NULL, 2, '김민서', '사원', 'M', '17-09-01', '2500000');
INSERT INTO tbl_employee VALUES(NULL, 3, '이은영', '부장', 'F', '90-09-01', '5500000');
INSERT INTO tbl_employee VALUES(NULL, 4, '한성일', '과장', 'M', '93-04-01', '5000000');
 
-- 영구적으로 저장
-- 오직 DML(INSERT,UPDATE,DELETE) 작업에서만 필요한 과정
COMMIT;

-- 이전 커밋으로 복귀 (직 전 커밋 단계로 돌아감)
-- ROLLBACK;

-- 수정/삭제를 위한 테스트 데이터
-- DATE(NOW()) : 현재 시간/날짜 중에서 날짜만 가져오는 함수
INSERT INTO tbl_employee VALUES(NULL, 1, '테스트', '테스트직급', 'F', DATE(NOW()), '50000000');

-- 행 수정하기 : 조건식 기준은 가능하면 기본키를 활용
-- UPDATE 테이블명 SET 칼럼 = 값, ... WHERE 조건식;
-- emp_id가 1005인 사원 이름 코알라로, 연봉 1.5배로 바꾸기
UPDATE tbl_employee SET emp_name = '코알라' WHERE emp_id = 1005;
UPDATE tbl_employee SET salary = salary * 1.5 WHERE emp_id = 1005;

-- 행 삭제하기 : 조건식 기준은 가능하면 기본키를 활용
-- DELETE FROM 테이블명 WHERE 조건식;
-- emp_id가 1005 이상인 사원 모두 삭제
DELETE FROM tbl_employee WHERE emp_id >= 1005;


-- 연습 문제

-- root 계정에서 권한 부여하고, 스키마 삭제 및 생성
DROP DATABASE IF EXISTS db_menu;
CREATE DATABASE IF NOT EXISTS db_menu;

-- 스키마 사용
USE db_menu;

-- 테이블 삭제하기
DROP TABLE IF EXISTS tbl_payment_order;
DROP TABLE IF EXISTS tbl_payment;
DROP TABLE IF EXISTS tbl_order_menu;
DROP TABLE IF EXISTS tbl_menu;
DROP TABLE IF EXISTS tbl_category;
DROP TABLE IF EXISTS tbl_order;

-- 테이블 생성하기
CREATE TABLE IF NOT EXISTS tbl_order
(
order_code INT NOT NULL AUTO_INCREMENT COMMENT '주문코드',
order_date VARCHAR(8) NOT NULL COMMENT '주문일자',
order_time VARCHAR(8) NOT NULL COMMENT '주문시간',
total_order_price INT NOT NULL COMMENT '총주문금액',
CONSTRAINT pk_order PRIMARY KEY(order_code)
)ENGINE=INNODB COMMENT '주문';

CREATE TABLE IF NOT EXISTS tbl_category
(
category_code INT NOT NULL AUTO_INCREMENT COMMENT '카테고리코드',
category_name VARCHAR(30) COMMENT '카테고리명',
ref_category_code INT COMMENT '상위카테고리코드',
CONSTRAINT pk_category PRIMARY KEY(category_code),
-- 같은 테이블 안에서 카테고리코드를 참조하는 상위카테고리코드 생성
CONSTRAINT fk_category FOREIGN KEY(ref_category_code) REFERENCES tbl_category(category_code)
)ENGINE=INNODB COMMENT '카테고리';

CREATE TABLE IF NOT EXISTS tbl_menu
(
menu_code INT NOT NULL AUTO_INCREMENT COMMENT '메뉴코드',
menu_name VARCHAR(30) NOT NULL COMMENT '메뉴명',
menu_price INT NOT NULL COMMENT '메뉴가격',
orderable_status CHAR(1) NOT NULL COMMENT '주문가능상태',
category_code INT COMMENT '카테고리코드',
CONSTRAINT pk_menu PRIMARY KEY(menu_code),
CONSTRAINT fk_category_menu FOREIGN KEY(category_code) REFERENCES tbl_category(category_code)
)ENGINE=INNODB COMMENT '메뉴';

CREATE TABLE IF NOT EXISTS tbl_order_menu
(
menu_code INT COMMENT '메뉴코드',
order_code INT COMMENT '주문코드',
order_amount INT COMMENT '주문수량',
CONSTRAINT pk_order_menu PRIMARY KEY(menu_code, order_code), -- 2가지 칼럼을 기본키로 설정
CONSTRAINT fk_menu_order_menu FOREIGN KEY(menu_code) REFERENCES tbl_menu(menu_code),
CONSTRAINT fk_order_order_menu FOREIGN KEY(order_code) REFERENCES tbl_order(order_code)
)ENGINE=INNODB COMMENT '주문별메뉴';

CREATE TABLE IF NOT EXISTS tbl_payment
(
payment_code INT NOT NULL AUTO_INCREMENT COMMENT '결제코드',
payment_date VARCHAR(8) COMMENT '결제일',
payment_time VARCHAR(8) COMMENT '결제시간',
payment_price INT COMMENT '결제금액',
payment_type VARCHAR(8) COMMENT '결제구분',
CONSTRAINT pk_payment PRIMARY KEY(payment_code)
)ENGINE=INNODB COMMENT '결제';

CREATE TABLE IF NOT EXISTS tbl_payment_order
(
order_code INT COMMENT '주문코드',
payment_code INT COMMENT '결제코드',
CONSTRAINT pk_payment_order PRIMARY KEY(order_code, payment_code),
CONSTRAINT fk_order_payment_order FOREIGN KEY(order_code) REFERENCES tbl_order(order_code),
CONSTRAINT fk_payment_payment_order FOREIGN KEY(payment_code) REFERENCES tbl_payment(payment_code)
)ENGINE=INNODB COMMENT '결제별주문';

-- 행 삽입하기
-- 메뉴, 카테고리 테이블만 내용 추가해두면, 나머지는 추후에 계산하여 짜면 됌
INSERT INTO tbl_category(category_name, ref_category_code) VALUES('커피', NULL);
INSERT INTO tbl_category(category_name, ref_category_code) VALUES('샌드위치', NULL);
INSERT INTO tbl_category VALUES(NULL, '논카페인', 1);
INSERT INTO tbl_category VALUES (NULL, '비건용', 2);

INSERT INTO tbl_menu(menu_name, menu_price, orderable_status, category_code) VALUES ('아메리카노', 4000, 'Y', '1');
INSERT INTO tbl_menu VALUES(NULL, '바닐라라떼', 4500, 'Y', '1');
INSERT INTO tbl_menu VALUES(NULL, '치즈햄샌드위치', 6000, 'Y', '2');
INSERT INTO tbl_menu VALUES(NULL, '딸기샌드위치', 5500, 'Y', '2'); 
INSERT INTO tbl_menu VALUES(NULL, '우롱티', 3700, 'N', '3');
INSERT INTO tbl_menu VALUES(NULL, '자몽허니블랙티', 4700, 'N', '3');
