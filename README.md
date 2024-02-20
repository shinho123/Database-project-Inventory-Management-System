# Database-project
데이터베이스 프로젝트

프로젝트 명 : 물품 재고 관리 시스템

팀원 : 김신호, 김도현, 신현균

수행 기간 : 2021.09.11 ~ 2021.12.08

역할 : PL/SQL 코드 작업, 디버깅, 모델 구현

## Ⅰ. 물품 재고 관리 시스템의 필요성

### 기업 및 매출의 관점
* 효율적인 재고 관리를 통한 재고 투자와 재고 비용의 절감
* 운전자금의 원활화 → 품절 방지를 통한 서비스율 향상
* 매출기화의 창출
* 조업의 안정화

### 고객관리의 관점
* 필요한 시점과 장소에 재고가 부족할 경우 고객들의 욕구 불충족
* 재고의 보관을 제대로 수행하지 않을 경우 재고 보관 비용 부패·도난·손상의 위험 존재

## 개발 목표

![image](https://github.com/shinho123/Database-project/assets/105840783/74a829a2-d37b-4164-85d5-46b120f69645)

* 재고의 보관성 : 적절한 시점에 적절한 장소에서 적절한 상품을 보유할 수 있도록 설계
* 재고의 가시성 : 보유중인 재고와 관련된 재고를 한눈에 파악하기 쉽도록 설계
* 재고의 주기성 : 보관된 물품 정보들은 주기적으로 갱신되어 항상 최신화를 유지할 수 있도록 설계

## 주요 기능

![image](https://github.com/shinho123/Database-project/assets/105840783/c1327e47-1470-469d-9c3e-ee00e592a16f)


## 설계 내용

### 고객 관리

![image](https://github.com/shinho123/Database-project/assets/105840783/1ffb775f-31c4-466a-ae56-ff1f28902184)

* 고객의 id, pw와 기본 정보(이름, 주소, 주민등록번호)를 담고 있으며, 고객의 id는 사람마다 고유해야 하므로 primary key로 지정함

### 물품 관리

![image](https://github.com/shinho123/Database-project/assets/105840783/40eb2c66-4b69-4439-8d2b-78e0fd3db6c5)

* 고객이 주문한 물품(물품번호, 물품명, 단가(가격), 재고량)의 정보를 담고 있다. 위와 같이 중복이 되지 않도록 고유의 물품번호를 가지고 있어야 하므로 물품번호를 primary key로 지정함

### 물품-{고객, 제조회사}

![image](https://github.com/shinho123/Database-project/assets/105840783/e8e54b92-df37-4fcc-897b-8f9845a0fd7d)

* 물품-고객 : 한명의 고객은 여러 개의 물품을 구매가능하다. (1:N) 그리고 물품은 여러 고객에 의해 구매되어짐(1:M)
* 물품-제조회사 : 물품은 한 곳의 회사에서 제조된다.(1:1) 또한 한 제조회사에서 여러 개의 물품을 제조하므로 1:M의 사상 수를 가짐


### ERD(Entity Relational Diagram)

![image](https://github.com/shinho123/Database-project/assets/105840783/8bbf19a2-de3b-45cc-94fe-8e3b547c4131)

## Ⅱ. 프로그램 실행 및 결과

### 자료 등록

#### 고객 정보 등록(Custom_info) (1/4)

![image](https://github.com/shinho123/Database-project/assets/105840783/323fe733-fda5-4837-9132-6b8040586c4f)

#### 납품 회사 정보 등록(Company_info) (2/4)

![image](https://github.com/shinho123/Database-project/assets/105840783/05a47c59-6b3d-447a-bb85-002c2b0eada8)

#### 물품 정보 등록(Product_info) (3/4)

![image](https://github.com/shinho123/Database-project/assets/105840783/49c4a687-1794-4829-ab4a-2593d4fe0f40)

#### 물품 구매 정보 등록(Product_purchase_info) (4/4)

![image](https://github.com/shinho123/Database-project/assets/105840783/3efa4925-dab5-48e0-9f56-9714f160de57)

### 자료 업데이트(Update) : 패스워드 변경, 주문(취소) 시 보유 재고량 변경

### 패스워드 변경

![image](https://github.com/shinho123/Database-project/assets/105840783/be17f498-34da-4581-9abb-797d04617aba)

* 현재 등록되어 있는 패스워드를 다른 패스워드로 변경할 경우 고객 정보(Custom_info)의 패스워드를 변경된 패스워드로 변경함
* 패스워드 변경 프로시저 형식 : exec ch_ps('사용자 id', '사용자 pw', '변경할 pw')
* 패스워드 변경 프로시저는 다음 3가지 원칙을 기반으로 설계하였으며, 하나라도 만족하지 않을 시 변경되지 않음)
  + 프로시저의 매개변수로 현재 등록된 아이디와 비밀번호를 입력하고 마지막 매개변수로 변경할 비밀번호를 입력한다.
  + 변경할 비밀번호가 현재 데이터베이스에 등록된 다른 비밀번호와 중복되지 않아야 한다.
  + 현재 비밀번호와 변경할 비밀번호가 중복되지 않아야 한다.

### 물품 주문 시 보유 재고량 변화 

#### 물품 재고량 변화 전 (1/2)
![image](https://github.com/shinho123/Database-project/assets/105840783/904f2394-b46b-46de-a656-9bc2ca33620a)


* 물품 구입 정보 입력 프로시저 형식 : exec product_purchase_info_input('사용자 id', '물품번호', '구매날짜', '구매수량')

![image](https://github.com/shinho123/Database-project/assets/105840783/ea3ba907-21d2-4a17-862a-c4d9ce5a69b6)

#### 물품 재고량 변화 후 (2/2)

![image](https://github.com/shinho123/Database-project/assets/105840783/a346acca-f175-4fcb-8f3a-cd61b58ae45f)

### 주문 취소 시 취소된 정보 삭제 및 보유 재고량 반환

![image](https://github.com/shinho123/Database-project/assets/105840783/8aa4ef52-5c09-42bc-aa68-6229256152c3)

* 주문을 취소하게 되면 물품 구매 정보(Product_purchase_info) 테이블에 취소 정보를 담고 있는 행을 삭제하고, 물품 정보(Product_info) 테이블에서 각 보유 재고량이 취소 수량만큼 증가함
* 주문취소 프로지저 형식 : exec delete_data('사용자 id', '물품번호', '주문수량')

#### 주문 취소 전 물품 정보 테이블(Product_info) (1/2)

![image](https://github.com/shinho123/Database-project/assets/105840783/9e5d9821-34ea-4255-a38f-d9ffbe546c69)

* exec delete_data('mvs021', 'A001', 3);
  + 아이디 : mvs021
  + 물품 번호 : A001(shirt)
  + 취소 수량 : 3개
  + 총 가격 : 39,000원
      
* exec delete_data('mvs021', 'E001', 2);
  + 아이디 : mvs021
  + 물품 번호 : E001(jeans)
  + 취소 수량 : 2개
  + 총 가격 : 24,000원

#### 주문 취소 후 물품 정보 테이블(Product_info) (2/2)

![image](https://github.com/shinho123/Database-project/assets/105840783/8e3207e5-3944-413b-b01b-7cdf3443a209)

### 자료 검색

![image](https://github.com/shinho123/Database-project/assets/105840783/444afc96-abb7-41df-8fb8-2bc70d91ce86)

* 지정된 날짜 사이의 데이터 검색
* 프로시저 설계 시 커서(검색 결과가 복수 행일 경우 복수 행의 결과를 행 단위로 처리해야함)를 함께 사용
* 자료 검색 프로시저 형식 : exec search_date('2021-11-28', '2021-12-04'); → 2021년 11월 28일부터 2021년 12월 04일까지의 데이터를 검색

#### 검색 결과(2021.11.28 ~ 2021.12.04)
![image](https://github.com/shinho123/Database-project/assets/105840783/9ae70148-e973-4ddc-9845-24673f41f84a)

### View를 통한 정보 확인 - 물품 구매 정보 통계 뷰

![image](https://github.com/shinho123/Database-project/assets/105840783/d13428d1-9f52-4c84-829a-7b5120f36312)

* 물품 구매 정보 테이블을 통계 산출하여 고객들의 총 구매 수량, 가격, 최대 구매 가격, 최소 구매 가격, 사용자 별 평균 지출 등을 확인하는 뷰를 생성

## Ⅲ. 결론

### 성과 및 기대효과

* 비용절감(Low Cost) : 재고를 관리하면서 발생하는 관리 비용이나 물품의 주문, 구매, 조달과 관련하여 드는 재고 비용의 절감효과를 불러옴
* 생산성 향상(Increase Productivity) : 작업 인원의 효율적 분배와 작업 동선 확보를 통해 인건비 절감의 효과를 불러옴
* AI(Artificial Intelligence)와 결합한 미래의 재고관리 : 기술 및 능력 있는 소비자들이 기업들의 재고 관리 방식을 변화시키고 있는 추세이며, 이들은 AI와 물류관리시스템을 융합하여 미래에는 물류 비용과 성능의 이상 현상이 발생하기 전에 미리 예측하며, 자동화가 상당한 규모로 발전가능
* 재고 정확도(Inventory Accuracy) : 불필요한 재고 구매 억제 및 수.발주 업무의 필수 요소이며 전상상의 물류와 실물 숫자가 일치하지 않아 발생할 수 있는 문제점도 예방가능

### 보완사항

* 스케줄러를 활용하여 특정 월 또는 년을 지정하여 월/년 단위 통계를 자동으로 산출 -> 사용자별 구매 통계량을 한눈에 파악할 수 있음 
