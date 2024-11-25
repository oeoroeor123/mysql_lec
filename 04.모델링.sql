-- root 계정으로 접속
-- greenit 계정에 db_company 데이터베이스(스키마) 사용 권한 부여하기
-- 현재 접속 중인 계정에서 스스로에게 사용 권한 부여하지 못함
-- GRANT ALL PRIVILEGES ON db_company.* TO 'greenit'@'%';


-- greenit 계정으로 접속

-- 데이터베이스(스키마) 삭제 형식
-- DROP {DATABASE | SCHEMA} [IF EXISTS] db_name;
DROP DATABASE IF EXISTS db_company;

-- 데이터베이스(스키마) 생성 형식
-- CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name [create_option] ...
CREATE DATABASE IF NOT EXISTS db_company;

-- 데이터베이스 사용
USE db_company;

-- 테이블 삭제
-- 참조하는 것 부터 지워나가기, 생성의 역순
DROP TABLE IF EXISTS tbl_proj_emp;
DROP TABLE IF EXISTS tbl_employee;
DROP TABLE IF EXISTS tbl_project;
DROP TABLE IF EXISTS tbl_department;

-- 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_department
(
dept_id INT NOT NULL AUTO_INCREMENT COMMENT '부서아이디',
dept_name VARCHAR(30) COMMENT '부서명',
location VARCHAR(50) COMMENT '위치',
CONSTRAINT pk_department PRIMARY KEY(dept_id)
)ENGINE=INNODB COMMENT'부서';

CREATE TABLE IF NOT EXISTS tbl_project
(
proj_id INT NOT NULL AUTO_INCREMENT COMMENT '프로젝트아이디',
proj_name VARCHAR(30) COMMENT '프로젝트명',
begin_date DATE COMMENT '시작일자',
end_date DATE COMMENT '종료일자',
CONSTRAINT pk_project PRIMARY KEY(proj_id)
)ENGINE=INNODB COMMENT '프로젝트';

CREATE TABLE IF NOT EXISTS tbl_employee
(
emp_id INT NOT NULL AUTO_INCREMENT COMMENT '사원아이디',
dept_id INT COMMENT '부서아이디',
emp_name VARCHAR(15) COMMENT '사원명',
position CHAR(10) COMMENT '직급',
gender CHAR(1) COMMENT '성별',
hire_date DATE COMMENT '입사일자',
salary INT COMMENT '연봉',
CONSTRAINT pk_employee PRIMARY KEY(emp_id),
CONSTRAINT fk_department_employee FOREIGN KEY(dept_id) REFERENCES tbl_department(dept_id)
)ENGINE=INNODB COMMENT '사원';

CREATE TABLE IF NOT EXISTS tbl_proj_emp
(
reg_id INT NOT NULL AUTO_INCREMENT COMMENT '등록아이디',
emp_id INT COMMENT '사원아이디',
proj_id INT COMMENT '프로젝트아이디',
state INT NOT NULL COMMENT '진행상태',
CONSTRAINT pk_proj_emp PRIMARY KEY(reg_id),
CONSTRAINT fk_employee_proj_emp FOREIGN KEY(emp_id) REFERENCES tbl_employee(emp_id),
CONSTRAINT fk_project_proj_emp FOREIGN KEY(proj_id) REFERENCES tbl_project(proj_id)
)ENGINE=INNODB COMMENT '프로젝트사원';
