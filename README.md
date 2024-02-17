# Database-project
데이터베이스 프로젝트

프로젝트 명 : 물품 재고 관리 시스템

팀원 : 김신호, 김도현, 신현균

역할 : PL/SQL 코드 작업, 디버깅, 모델 구현

# 물품 재고 관리 시스템의 필요성

## 기업 및 매출의 관점
* 효율적인 재고 관리를 통한 재고 투자와 재고 비용의 절감
* 운전자금의 원활화 → 품절 방지를 통한 서비스율 향상
* 매출기화의 창출
* 조업의 안정화

## 고객관리의 관점
* 필요한 시점과 장소에 재고가 부족할 경우 고객들의 욕구 불충족
* 재고의 보관을 제대로 수행하지 않을 경우 재고 보관 비용 부패·도난·손상의 위험 존재

# 개발 목표

![image](https://github.com/shinho123/Database-project/assets/105840783/74a829a2-d37b-4164-85d5-46b120f69645)

* 재고의 보관성 : 적절한 시점에 적절한 장소에서 적절한 상품을 보유할 수 있도록 설계
* 재고의 가시성 : 보유중인 재고와 관련된 재고를 한눈에 파악하기 쉽도록 설계
* 재고의 주기성 : 보관된 물품 정보들은 주기적으로 갱신되어 항상 최신화를 유지할 수 있도록 설계

# 주요 기능

![image](https://github.com/shinho123/Database-project/assets/105840783/c1327e47-1470-469d-9c3e-ee00e592a16f)


# 설계 내용

## 고객 관리

![image](https://github.com/shinho123/Database-project/assets/105840783/1ffb775f-31c4-466a-ae56-ff1f28902184)

* 고객의 id, pw와 기본 정보(이름, 주소, 주민등록번호)를 담고 있으며, 고객의 id는 사람마다 고유해야 하므로 primary key로 지정함

## 물품 관리

![image](https://github.com/shinho123/Database-project/assets/105840783/40eb2c66-4b69-4439-8d2b-78e0fd3db6c5)

* 고객이 주문한 물품(물품번호, 물품명, 단가(가격), 재고량)의 정보를 담고 있다. 위와 같이 중복이 되지 않도록 고유의 물품번호를 가지고 있어야 하므로 물품번호를 primary key로 지정함

## 물품-{고객, 제조회사}

![image](https://github.com/shinho123/Database-project/assets/105840783/e8e54b92-df37-4fcc-897b-8f9845a0fd7d)

* 물품-고객 : 한명의 고객은 여러 개의 물품을 구매가능하다. (1:N) 그리고 물품은 여러 고객에 의해 구매되어짐(1:M)
* 물품-제조회사 : 물품은 한 곳의 회사에서 제조된다.(1:1) 또한 한 제조회사에서 여러 개의 물품을 제조하므로 1:M의 사상 수를 가짐


# ERD(Entity Relational Diagram)

![image](https://github.com/shinho123/Database-project/assets/105840783/8bbf19a2-de3b-45cc-94fe-8e3b547c4131)
