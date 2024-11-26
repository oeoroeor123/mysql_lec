USE db_company;

/*
CROSS JOIN
- 조인 조건이 없는 조인 방식, CROSS JOIN 키워드 사용
- 조인 조건이 잘못 작성된 경우에도 수행
*/

/* JOIN 절 공부하기 */
-- 1. 모든 사원의 부서번호, 부서명, 사원번호, 사원명 조회하기
-- ON (JOIN 조건)이 없을 경우, 크로스 조인으로 1:1로 조회가 진행됨
SELECT d.dept_id, e.dept_id, dept_name, emp_id, emp_name
 FROM tbl_department d CROSS JOIN tbl_employee e;
 
/* 
INNER JOIN 
 - 두 테이블이 모두 가지고 있는 데이터를 조회할 때 사용
 - 반드시 올바른 조인 조건을 작성해야 함
*/

/*
테이블 작성 방법 (FROM 절, ON 절)
    FROM, ON "Drive Table" JOIN "Driven Table"
    Drive Table : 조인을 주동으로 하는 테이블(PK를 가지고 있는 테이블 또는 행(칼럼)이 적은 테이블 사용)
    Driven Table : 조인 시 필요한 데이터를 가져오는 테이블
*/

-- 2. 모든 사원의 부서번호, 부서명, 사원번호, 사원명 조회하기
SELECT d.dept_id, e.dept_id, dept_name, emp_id, emp_name
 FROM tbl_department d INNER JOIN tbl_employee e
   ON d.dept_id = e.dept_id;
   
-- 3. 대구에 근무하는 사원 조회하기
SELECT emp_id, e.dept_id, emp_name, position, gender, hire_date, salary
  FROM tbl_department d INNER JOIN tbl_employee e
    ON d.dept_id = e.dept_id
 WHERE location = '대구';
 
-- 4. 지역 별 근무하는 사원 수 조회하기
SELECT location, COUNT(*)
  FROM tbl_department d INNER JOIN tbl_employee e
    ON d.dept_id = e.dept_id
 GROUP BY location;
 
-- 5. (db_menu 스키마) 메뉴코드, 메뉴명, 가격, 카테고리코드, 주문가능여부 조회하기
USE db_menu; 
   
SELECT menu_code, menu_name, menu_price, category_name, orderable_status
  FROM tbl_category c INNER JOIN tbl_menu m -- 1대 다관계, 카테고리 1개에 여러 메뉴가 들어감
    ON c.category_code = m.category_code;

    
/*
OUTER JOIN
 - 어느 한 테이블만 가지고 있는 데이터를 조회할 때 사용
 - LEFT (OUTER) JOIN : JOIN을 기준으로, 첫 번째 테이블(왼쪽 테이블)의 모든 데이터는 항상 조회되는 방식
 - RIGHT (OUTER) JOIN : 두번째 테이블(오른쪽 테이블)의 모든 데이터는 항상 조회되는 방식
*/

-- 6. 부서 별 사원 수 조회하기, 근무 중인 사원이 없으면 0을 표시
USE db_company;

SELECT dept_name, COUNT(emp_id) -- COUNT 칼럼은 employee 테이블 칼럼 중 pk(모두가 가지고 있는)값으로 지정
  FROM tbl_department d LEFT JOIN tbl_employee e
    ON d.dept_id = e.dept_id
 GROUP BY d.dept_id, dept_name;
 
-- 7. (db_menu 스키마) 메뉴이름, 모든 카테고리이름 조회하기
USE db_menu;

SELECT menu_name, category_name
  FROM tbl_category c LEFT JOIN tbl_menu m
    ON c.category_code = m.category_code;

/* 
SELF JOIN
 - 테이블 하나를 대상으로 행과 행 사이 관계를 찾는 조인 방식
*/

-- 8. 카테고리이름, 상위카테고리이름 조회하기
SELECT a.category_name AS 카테고리, b.category_name AS 상위카테고리
  FROM tbl_category a INNER JOIN tbl_category b -- 같은 category 테이블 2번 작성하고, a/b로 별명 구분
    ON a.ref_category_code = b.category_code -- a 테이블 상위 카테고리와 b 테이블 카테고리를 연결하고, 각 테이블 카테고리 이름을 조회함
 WHERE a.ref_category_code IS NOT NULL; -- 성능 향상을 위해 사용, a 테이블의 NULL 값은 제외하고 조회하여 성능을 높혀줌
 
