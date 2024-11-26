USE db_company;

/* 
중첩 서브쿼리
 - WHERE절에서만 사용 / 서브쿼리 먼저 실행 후 메인쿼리에 내용 전달해 동작
단일 행 서브쿼리
 - 그룹 함수 (SUM() : 합계 , AVG() : 평균, MAX() : 최대값, MIN() : 최소값, COUNT() : 갯 수)를 사용해 어떤 1개의 값을 얻어냄
*/

-- 1. 평균 급여 이상을 받는 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE salary >= (SELECT AVG(salary) FROM tbl_employee); -- WHERE 절에서 함수 사용이 불가해, 내부 쿼리를 하나 추가
 
-- 2. 사원번호가 1001인 사원의 직책을 가진 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE position = (SELECT position FROM tbl_employee WHERE emp_id = 1001);
 
/* 
중첩 서브쿼리
다중 행 서브쿼리
IN, ANY, ALL 연산자 사용하여 여러개 값을 얻어냄 
*/

-- 3. 부서명이 '영업부'인 부서에 근무하는 사원 조회하기
SELECT emp_id, dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_employee
 WHERE dept_id IN (SELECT dept_id FROM tbl_department WHERE dept_name = '영업부');
 -- IN : (= OR) 또는을 의미함, 서브쿼리의 결과 중에서 하나라도 일치하면 true
 
/*
스칼라 서브쿼리
 - SELECT 절에서 사용 / 하나의 값을 반환(단일 행 서브쿼리) 
*/

-- 4. 사원 번호가 1002인 사원의 정보와 전체 급여 평균 조회하기
USE db_company;

SELECT emp_id, emp_name, salary, (SELECT AVG(salary) FROM tbl_employee) AS 전체급여평균
  FROM tbl_employee
 WHERE emp_id = 1002;

 /*
 인라인 뷰 (뷰 = 테이블)
 FROM 절에서 사용 / 테이블 형식의 결과를 반환함
 */
 
 -- 5. 부서별 급여 평균 중 가장 높은 급여 평균 조회하기
 SELECT MAX(average) 
   FROM (SELECT AVG(salary) AS average
           FROM tbl_employee 
          GROUP BY dept_id) AS tbl_average; -- 인라인뷰 (파생 테이블) 서브쿼리는 별명이 필수로 지정되어야 함
  
 /* 
 상관 서브쿼리
  - 메인 쿼리 데이터가 서브 쿼리로 흘러 들어가는 형태 > 메인 쿼리 내용이 서브 쿼리에 영향을 미침
  - 메인 쿼리 테이블(FROM 절)에 별명을 주고, 서브 쿼리에 연결될 수 있게 공통되는 쿼리를 적고 '서브쿼리 = 별명.메인쿼리' 형태로 작성
 */
 
-- 6. [스칼라 서브쿼리] 전체 사원의 정보와 부서 별 급여 평균 조회하기
SELECT emp_id, emp_name, dept_id, salary, (SELECT AVG(salary) FROM tbl_employee WHERE dept_id = e.dept_id) AS 부서급여평균
  FROM tbl_employee e;
  
-- 7. [스칼라 서브쿼리] 전체 사원의 정보와 부서명 조회하기
SELECT emp_id, emp_name, dept_id, (SELECT dept_name FROM tbl_department WHERE dept_id = e.dept_id)AS 부서이름, position, gender, hire_date, salary
  FROM tbl_employee e;
  
 -- 8. [중첩 서브쿼리] (db_menu 스키마) 메뉴 가격이 카테고리별 평균 메뉴 가격보다 높은 메뉴 조회하기
 -- 메인 쿼리의 값(m.category_code)이 서브 쿼리(category_code)로 전달되어 서브 쿼리 값이 달라짐
USE db_menu; 

SELECT menu_code, menu_name, menu_price, category_code, orderable_status
  FROM tbl_menu m -- 메인 쿼리 테이블에 별명 지정
 WHERE menu_price > (SELECT AVG(menu_price) FROM tbl_menu WHERE category_code = m.category_code); -- 카테고리 별 평균 메뉴 가격