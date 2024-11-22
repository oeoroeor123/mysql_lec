-- 사용자 추가 형식
-- CREATE USER '사용자'@'호스트' IDENTIFIED BY '비밀번호';

-- 호스트
-- localhost : 내부 접근
-- %		 : 외부 접근 (내부 접근도 가능)
-- 1.1.1.1   : 특정 IP에서만 접근

-- greenit 계정 만들기
CREATE USER 'greenit'@'%' IDENTIFIED BY 'greenit';

-- greenit 계정 삭제하기
-- DROP USER 'greenit'@'%';

-- 스키마 확인 (데이터베이스 확인)
SHOW DATABASES;

-- mysql 스키마 사용하기 (기본 제공되는 스키마)
-- 쿼리문 작성 전, 사용 할 스키마 (데이터베이스)를 선택해야 함 (필수!)
USE mysql;

-- greenit 사용자 확인하기
-- 사용자 정보가 저장된 user 테이블 조회하기 (greenit 사용자를 확인하기 위함)
SELECT * FROM user;

-- testdb 스키마 만들기 (MySQL에서는 스키마와 데이터베이스가 같은 개념으로 사용된다.)
-- 방법 1) CREATE DATABASE 데이터베이스명;
-- 방법 2) CREATE SCHEMA 스키마명;
CREATE DATABASE testdb;

-- testdb 스키마 삭제하기
-- DROP DATABASE testdb;

-- 스키마 생성 후 왼쪽 Navigator 창에서 새로고침 클릭하면 추가된 스키마를 확인할 수 있다.

-- greenit 사용자에게 권한 부여하기
-- GRANT 권한종류 PRIVILEGES ON 스키마.객체 TO '사용자'@'호스트';
GRANT ALL PRIVILEGES ON testdb.* TO 'greenit'@'%'; -- testdb 스키마의 모든 객체 사용 권한을 부여함
GRANT ALL PRIVILEGES ON db_company.* TO 'greenit'@'%'; -- db_company 스키마의 모든 객체 사용 권한을 부여함

-- greenit 사용자의 권한 확인하기
SHOW GRANTS FOR 'greenit'@'%';