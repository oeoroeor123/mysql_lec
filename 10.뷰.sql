USE db_company;

-- 사원 정보와 부서 정보를 자주 조회하는 경우
-- 조인 쿼리문을 하나의 뷰로 저장해두면 쉽게 조인을 사용할 수 있다.

-- 뷰 = 쿼리문을 저장해두고 있는 가상 테이블, 테이블 원본의 데이터가 변경되면 뷰에도 반영이 된다.
-- (INSERT, DELETE, UPDATE 모두 반영됨)

-- 뷰 생성하기 (쿼리문을 저장해두는 방식)
CREATE VIEW v_emp AS
  SELECT emp_id, d.dept_id, dept_name, location, emp_name, position, gender, hire_date, salary
    FROM tbl_department d INNER JOIN tbl_employee e
      ON d.dept_id = e.dept_id;

-- 뷰가 있을 경우, 새로운 데이터로 바꾸는 형태
CREATE OR REPLACE VIEW v_emp AS
  SELECT emp_id, d.dept_id, dept_name, location, emp_name, position, gender, hire_date, salary
    FROM tbl_department d INNER JOIN tbl_employee e
      ON d.dept_id = e.dept_id;
            
-- 뷰 조회하기
SELECT * FROM v_emp;
SELECT * FROM v_emp WHERE dept_id = 3;
SELECT *
  FROM v_emp a LEFT JOIN tbl_proj_emp b -- 테이블 3개짜리 조인 = v_emp 테이블 2개 + tbl_proj_emp 테이블 1개 
    ON a.emp_id = b.emp_id;

-- INSERT 결과가 VIEW에 반영되는가 ? OK
INSERT INTO tbl_employee VALUES(NULL, 3, '홍길동', '사원', 'F', '2015-12-17', 3000000);
COMMIT;

