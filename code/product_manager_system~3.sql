-- 고객정보 입력 프로시저 --
CREATE OR REPLACE PROCEDURE custom_input
(
    cus_id1 IN custom_info.cus_id%TYPE,
    cus_pw1 IN custom_info.cus_pw%TYPE,
    cus_name1 IN custom_info.cus_name%TYPE,
    cus_adress1 IN custom_info.cus_adress%TYPE,
    cus_num1 IN custom_info.cus_num%TYPE
)
IS
    check_id NUMBER :=0;
BEGIN
    SELECT COUNT(*) INTO check_id
    FROM custom_info
    WHERE cus_id = cus_id1;
    IF check_id = 0 then
        INSERT INTO custom_info 
        VALUES (cus_id1, cus_pw1, cus_name1, cus_adress1, cus_num1);
        dbms_output.put_line('성공적으로 등록되었습니다.');
        COMMIT;
    ELSE
        dbms_output.put_line('오류 : 아이디가 중복됩니다.');
    END IF;
EXCEPTION 
    WHEN OTHERS THEN
        ROLLBACK;
END custom_input;
-- 프로시저를 통한 고객 정보 입력 --
set serveroutput on;
exec custom_input('shk240', 'dongseo123', '김신호', '동서로-77','999999-111111'); 
exec custom_input('shk123', 'dongseo456', '신현균', '동서로-98','888888-222222');
exec custom_input('dhk456', 'dongseo678', '김도현', '동서로-10','777777-333333');
exec custom_input('drt789', 'everyda521', '홍길동', '달서구-24','666666-444444');
exec custom_input('oeq248', 'dkwlqne413', '임꺽정', '수영로-56','555555-555555'); 
exec custom_input('oie980', 'riwnqwy491', '김철수', '영등로-11','444444-666666'); 
exec custom_input('mvs021', 'oepwr2d678', '이영희', '가로수-86','333333-777777'); 
exec custom_input('uiq812', 'qmdmnf8620', '김민재', '사하구-26','222222-888888');
exec custom_input('inr324', 'qoeprw2489', '김수현', '중구-88','111111-999999'); 
exec custom_input('qop011', 'dnskc13558', '이도현', '진구-15','987654-000000'); 
-- 회사 정보 입력 프로시저 --
CREATE OR REPLACE PROCEDURE comp_info_input
(
    vcomp_name IN company_info.comp_name%TYPE,
    vcomp_num IN company_info.comp_num%TYPE,
    vcomp_addr IN company_info.comp_addr%TYPE,
    vcomp_tel IN company_info.comp_tel%TYPE
)
IS
    check_comp_num number := 0;
BEGIN
    SELECT COUNT(*) INTO check_comp_num 
        FROM company_info
        WHERE comp_num = vcomp_num;
        
        IF check_comp_num = 0 THEN
            INSERT INTO company_info VALUES(vcomp_name, vcomp_num, vcomp_addr, vcomp_tel);
            dbms_output.put_line('성공적으로 등록되었습니다.');
            COMMIT;
        ELSE
            dbms_output.put_line('오류 : 회사번호가 중복됩니다.');
        END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
    END comp_info_input;
-- 프로시저를 통한 회사 정보 입력 --
exec comp_info_input('goldman', 6029182, '달서구-99', 051123456); -- goldman 회사 정보
exec comp_info_input('hanyang', 9312045, '북구-54', 036789191); -- hanyang 회사 정보
exec comp_info_input('dongseo', 2304123, '사상구-12', 051222333); -- dongseo 회사 정보
--프로시저를 통한 물품 정보 입력--
CREATE OR REPLACE PROCEDURE product_info_input
(
    vprod_name IN product_info.prod_name%TYPE,
    vprod_num IN product_info.prod_num%TYPE,
    vprod_price IN product_info.prod_price%TYPE,
    vcomp_num IN product_info.comp_num%TYPE,
    vprod_date IN product_info.prod_date%TYPE,
    vprod_quan IN product_info.prod_quan%TYPE
)
IS
BEGIN
    dbms_output.put_line('물품 등록이 완료되었습니다.');
    INSERT INTO product_info(prod_name, prod_num, prod_price, comp_num, prod_date, prod_quan)
    VALUES (vprod_name, vprod_num, vprod_price, vcomp_num, vprod_date, vprod_quan);
    UPDATE product_info
    SET prod_stock = prod_stock + vprod_quan
    WHERE prod_quan = vprod_quan;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END product_info_input;



-- 물품명, 물품번호, 물품단가, 회사번호, 납품수량, 납품날짜
delete from product_info
where prod_name = 'shirt' or prod_name = 'cap' or prod_name = 'sweater' or prod_name = 'jacket' or prod_name = 'jeans';

exec product_info_input('shirt', 'A001', 13000, 6029182, '2021-11-27', 250);
exec product_info_input('cap', 'B001', 8000, 2304123, '2021-11-28', 100);
exec product_info_input('sweater', 'C001', 35000, 9312045, '2021-12-02', 80);
exec product_info_input('jacket', 'D001', 50000, 9312045, '2021-12-02', 10);
exec product_info_input('jeans', 'E001', 12000, 2304123, '2021-12-01', 50);

-- 물품 구입 정보 입력 프로시저 --
-- 물품을 구입하면 개수만큼 PRODUCT_INFO의 재고량에서 감소됨 --
CREATE OR REPLACE PROCEDURE product_purchase_info_input
(
    vcus_id IN product_purchase_info.cus_id%TYPE,
    vprod_num IN product_purchase_info.prod_num%TYPE,
    vpurc_date IN product_purchase_info.purc_date%TYPE,
    vpurc_quan IN product_purchase_info.purc_quan%TYPE,
    vt_price IN product_purchase_info.t_price%TYPE
)
IS
BEGIN
    INSERT INTO product_purchase_info
    VALUES(vcus_id, vprod_num, vpurc_date, vpurc_quan, vt_price);
    UPDATE product_info
    SET
    prod_stock = prod_stock - vpurc_quan
    WHERE
    prod_stock != 0 AND prod_num = vprod_num;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END PRODUCT_PURCHASE_INFO_INPUT;
-- 프로시저를 통한 물품 구입 정보 입력 --
delete from product_purchase_info
where cus_id = 'shk240' or cus_id = 'shk123' or cus_id = 'dhk456' or cus_id = 'mvs021' or cus_id = 'uiq812';

exec product_purchase_info_input('shk123', 'A001', '2021-11-29 09:22:12', 2, 26000);
exec product_purchase_info_input('shk123', 'B001', '2021-11-30 11:43:01', 4, 32000);
exec product_purchase_info_input('shk123', 'E001', '2021-11-29 14:01:44', 1, 12000);
exec product_purchase_info_input('shk240', 'C001', '2021-12-03 11:19:45', 1, 35000);
exec product_purchase_info_input('shk240', 'A001', '2021-12-09 15:28:10', 4, 52000);
exec product_purchase_info_input('uiq812', 'A001', '2021-11-29 09:22:12', 2, 26000);
exec product_purchase_info_input('uiq812', 'B001', '2021-12-08 12:45:22', 3, 24000);
exec product_purchase_info_input('uiq812', 'D001', '2021-12-06 18:39:23', 2, 100000);
exec product_purchase_info_input('uiq812', 'C001', '2021-12-07 23:10:01', 2, 70000);
exec product_purchase_info_input('mvs021', 'E001', '2021-12-01 19:32:56', 2, 24000);
exec product_purchase_info_input('mvs021', 'A001', '2021-12-02 21:54:10', 3, 39000);
exec product_purchase_info_input('mvs021', 'B001', '2021-12-07 22:56:00', 5, 40000);
exec product_purchase_info_input('dhk456', 'A001', '2021-12-01 12:32:10', 5, 65000);
exec product_purchase_info_input('dhk456', 'C001', '2021-12-24 10:42:10', 1, 35000);
exec product_purchase_info_input('dhk456', 'A001', '2021-12-14 21:12:11', 1, 13000);

-- 물품 주문 취소 프로시저 --
-- 주문 취소 시 해당 물품의 재고량 증가와 물품 구입 정보 테이블에서 해당 행 삭제 --
CREATE OR REPLACE PROCEDURE DELETE_DATA
(
    vcus_id product_purchase_info.cus_id%TYPE,
    vprod_num product_purchase_info.prod_num%TYPE,
    vpurc_quan product_purchase_info.purc_quan%TYPE,
    vt_price product_purchase_info.t_price%TYPE
)
IS
    i number:=0;
BEGIN
    DELETE FROM PRODUCT_PURCHASE_INFO
    WHERE cus_id = vcus_id AND prod_num = vprod_num AND purc_quan = vpurc_quan AND t_price = vt_price;
    i := vpurc_quan;
    
    UPDATE PRODUCT_INFO
    SET
    prod_stock = prod_stock + i
    WHERE prod_num = vprod_num;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END DELETE_DATA;
EXEC DELETE_DATA('mvs021', 'A001', 3, 39000);
EXEC DELETE_DATA('mvs021', 'E001', 2, 24000);
-- 패스워드 변경 프로시저 --
CREATE OR REPLACE PROCEDURE CH_PS
(
    I_D VARCHAR2,
    PRESENT_P_S VARCHAR2,
    CHANGE_P_S VARCHAR2
)
IS
BEGIN
    UPDATE CUSTOM_INFO
    SET
    CUS_PW = CHANGE_P_S
    WHERE
    NOT CHANGE_P_S IN (SELECT CUS_PW FROM CUSTOM_INFO) AND
    CUS_ID = I_D AND
    CUS_PW = PRESENT_P_S AND
    CUS_PW != CHANGE_P_S;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END CH_PS;
EXEC CH_PS('shk240', 'dongseo679', 'dongseo123');

-- 날짜 조회 프로시저 --
CREATE OR REPLACE PROCEDURE SEARCH_DATE
(
    date1 IN date,
    date2 IN date
)
IS
    CURSOR DEPTNO_CURSOR IS SELECT cus_id, prod_num, purc_date, purc_quan, t_price FROM product_purchase_info WHERE purc_date BETWEEN date1 and date2;
    vcus_id product_purchase_info.cus_id%type;
    vprod_num product_purchase_info.prod_num%type;
    vpurc_date product_purchase_info.purc_date%type;
    vpurc_quan product_purchase_info.purc_quan%type;
    vt_price product_purchase_info.t_price%type;
BEGIN
    OPEN DEPTNO_CURSOR;
    DBMS_OUTPUT.PUT_LINE('검색 결과 입니다.');
    LOOP
        FETCH DEPTNO_CURSOR INTO vcus_id, vprod_num, vpurc_date, vpurc_quan, vt_price;
        EXIT WHEN DEPTNO_CURSOR%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('구매아이디 : ' || vcus_id || ',' || ' ' || '물품번호 : ' || vprod_num || ',' || ' ' || '구매수량 : ' || vpurc_quan || ',' || ' ' || '총 가격 : ' || vt_price || ',' || ' ' || '구매날짜 : ' || vpurc_date);
    END LOOP;
    CLOSE DEPTNO_CURSOR;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
END SEARCH_DATE;
EXEC search_date('2021-11-28','2021-12-04');

-- 데이터 타입 변경 --
ALTER TABLE PRODUCT_PURCHASE_INFO MODIFY PURC_QUAN NUMBER;
ALTER TABLE PRODUCT_PURCHASE_INFO MODIFY T_PRICE NUMBER;

-- 물품 구매 정보 통계 뷰 생성 --
CREATE OR REPLACE VIEW PROD_PUR_STAT
AS
    SELECT cus_id, SUM(purc_quan) prod_quan, SUM(t_price) prod_total, MAX(t_price) prod_max, MIN(t_price) prod_min, round(AVG(t_price), 0) prod_avg
    FROM product_purchase_info
    GROUP BY cus_id ORDER BY prod_total DESC;
    COMMIT;

        
        
SELECT * FROM PROD_PUR_STAT;


    