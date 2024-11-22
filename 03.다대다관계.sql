/*
  다대다 관계
  두 엔티티 사이에 다대다 관계가 존재할 수 있다.
  예시 : 학생과 과목(학생 - 수강신청 - 과목), 고객과 상품(고객 - 구매내역 - 상품) 등
  다대다 관계는 두 엔티티의 직접 연결이 불가능하므로, 새로운 엔티티를 추가하여 2개의 일대다 관계로 구성한다.
*/

-- 학생, 수강신청, 과목 테이블

USE testdb;

-- 테이블 삭제
DROP TABLE IF EXISTS tbl_class;
DROP TABLE IF EXISTS tbl_subject;
DROP TABLE IF EXISTS tbl_student;

-- 학생 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_student
(
stu_id CHAR(5) NOT NULL UNIQUE COMMENT '학번',
stu_name VARCHAR(5)  NOT NULL COMMENT '성명',
stu_age TINYINT COMMENT '나이',
CONSTRAINT pk_student PRIMARY KEY(stu_id)
)ENGINE=INNODB COMMENT '학생 테이블';

-- 과목 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_subject
(
sub_cd CHAR(2) NOT NULL UNIQUE COMMENT '과목코드',
sub_name VARCHAR(5) NOT NULL COMMENT '과목명',
prof_name VARCHAR(5) NOT NULL COMMENT '교수명',
CONSTRAINT pk_subject PRIMARY KEY(sub_cd)
)ENGINE=INNODB COMMENT '과목 테이블';

-- 수강신청 테이블 생성
CREATE TABLE IF NOT EXISTS tbl_class
(
stu_id CHAR(5) NOT NULL COMMENT'학번',
sub_cd CHAR(2) NOT NULL COMMENT '과목코드',
CONSTRAINT pk_class PRIMARY KEY(stu_id, sub_cd), -- 두가지 칼럼을 합쳐서 기본키로 설정
CONSTRAINT fk_student_class FOREIGN KEY(stu_id) REFERENCES tbl_student(stu_id),
CONSTRAINT fk_subject_class FOREIGN KEY(sub_cd) REFERENCES tbl_subject(sub_cd)
)ENGINE=INNODB COMMENT '수강신청 테이블';
