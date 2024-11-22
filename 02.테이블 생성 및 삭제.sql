-- 테이블을 저장할 스키마 선택하기
USE testdb;

/*tbl_order
테이블은 부모 테이블을 먼저 만들고, 자식 테이블을 나중에 만든다. (외래키(FK)를 가지고 있는 자식 테이블은 참조 값인 부모 테이블이 있어야 만들 수 있다.) 
테이블 삭제와 생성 순서는 항상 역순으로 작업한다.
*/

-- 테이블 삭제 : 테이블이 있으면 지워라 
-- CASCADE : 참조 중인 테이블이 존재하면 함께 삭제하는 옵션 (MySQL에서는 동작 안함)
DROP TABLE IF EXISTS tbl_order; -- 주문 테이블 (자식)
DROP TABLE IF EXISTS tbl_product;  -- 제품 테이블 (부모)

-- 제품 테이블 만들기 : 테이블이 없으면 만들어라
CREATE TABLE IF NOT EXISTS tbl_product
( 
  prod_id    INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '제품코드',
  prod_name  VARCHAR(20) NULL COMMENT '제품이름', -- NULL : 작성해도 되고, 안해도 되는 선택사항 디폴트값 (NOT NULL : 필수)
  price      INT(5) COMMENT '제품가격', -- INT(5) = 99,999원짜리 제품으로 글자 수 제한
  stock      SMALLINT DEFAULT 0 COMMENT '제품재고'
) ENGINE=INNODB COMMENT '제품'; 

-- 주문 테이블 만들기 : 테이블이 없으면 만들어라
CREATE TABLE IF NOT EXISTS tbl_order
(
  -- 위에 칼럼을 넣고, 아래에 기본키/외래키 내용을 작성해줌
  order_id   INT NOT NULL AUTO_INCREMENT COMMENT '주문번호',
  order_user VARCHAR(20) COMMENT '주문자',
  prod_id    INT COMMENT '제품코드', -- 외래키
  order_dt   DATETIME DEFAULT NOW() COMMENT '주문일자', 
  PRIMARY KEY(order_id),
  FOREIGN KEY(prod_id) REFERENCES tbl_product(prod_id)  -- 외래키 REFERENCES 참조 내용 > 마지막 순서에 배치
) ENGINE=INNODB COMMENT '주문';

-- 주문 테이블의 자동 증가 순번은 1000에서 시작한다.
ALTER TABLE tbl_order AUTO_INCREMENT = 1000;


-- 연습용
-- 테이블 삭제
DROP TABLE IF EXISTS tbl_customer; -- 고객 테이블 삭제 (자식 테이블)
DROP TABLE IF EXISTS tbl_bank; -- 뱅크 테이블 삭제 (부모 테이블)

-- 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_bank
(
  bank_id VARCHAR(20) NOT NULL COMMENT '은행코드',
  bank_name VARCHAR(30) COMMENT '은행이름',
  CONSTRAINT pk_bank PRIMARY KEY(bank_id) -- 제약 조건에 이름을 지정한 기본키
) ENGINE=INNODB COMMENT '은행';

CREATE TABLE IF NOT EXISTS tbl_customer
(
  cust_id INT NOT NULL AUTO_INCREMENT COMMENT '고객번호',
  cust_name VARCHAR(30) NOT NULL COMMENT '고객이름',
  phone VARCHAR(30) UNIQUE COMMENT '핸드폰번호',
  age SMALLINT CHECK(age BETWEEN 0 AND 100) COMMENT '나이', -- 0~100사이만 가능
  bank_id VARCHAR(20) COMMENT '은행코드',
  CONSTRAINT pk_customer PRIMARY KEY(cust_id),
  CONSTRAINT fk_bank_customer FOREIGN KEY(bank_id) REFERENCES tbl_bank(bank_id) 
) ENGINE=INNODB COMMENT '고객';