# 어디로 GO?
## 프로젝트 개요
다양한 여행 관련 정보를 제공하고 사용자가 여행지를 선택하는 과정에서 도움을 주는 웹사이트를 개발하였습니다. 국문관광정보, 기상청, 국토 교통부, 네이버 등 다양한 OPEN API를 사용하여 사용자에게 주요 여행지의 장소 정보, 날씨 상황 그리고 위치를 지도로 제공합니다.
사용자들의 가독성, 편의성을 목표로 하여 개발하였습니다.

- 전체 기능
  - 회원관리 CRUD : Google Naver Kakao 로그인
  - 여행지 : 전국의 모든 여행지 리스트 및 상세보기, 카테고리 및 지역별 분류 
  - 날씨 : 해당 지역의 날씨 정보 조회
  - 지도 : 사용자의 위치, 해당 지역의 여행지를 조회
  - 게시판 : 리뷰게시판, Q&A 게시판
  - 플래너 : 나만의 여행 플래너 작성
  - 놀이 : 롤렛, 여행지 이상형 월드컵 으로 여행 추천 시스템 
  - 교통 정보 : 해당 장소까지의 버스정보, 열차정보 조회 

- 담당 기능
  - 여행지 게시판
  - 메인페이지
  - 플래너

## 개발 기간
  - 2024.06.17 ~ 2024.07.17

## 참여 인원 : 
  - 5명 (프론트엔드, 백엔드 구분 X)


## 기술 스택
  - 운영체제 : Window, OS
  - 개발 언어 : Java (11)
  - Front-End : HTML5, CSS3, JavaScript, JQuery, Ajax
  - Back-End : JAVA, JSP&Servlet
  - FrameWork/Library : SpringLegacy, Mybatis, cos, jstl, lombok, Ajax..
  - 개발 도구 : STS3, Visual Studio Code
  - DB : Oracle 11c
  - API : NAVER MAP, 공공데이터 포털 Open API
  - Collaboration: GitHub, Slack

## ERD
![WHEREGO-ERD](https://github.com/user-attachments/assets/ae01625e-783f-49ac-9d63-4d597e4275f9)

## VIEW

### 메인 화면
![main-gif](https://github.com/user-attachments/assets/a4c82995-a636-4a33-8e7d-3bc9fba5e045)

### 여행지 리스트 및 상세보기
![trip-gif](https://github.com/user-attachments/assets/9ad43047-9573-4044-82dd-36487ad498f6)

### 플래너 작성 및 상세보기
![planner-gif](https://github.com/user-attachments/assets/e0d1acd2-9339-4e00-959b-a218194b9d32)

## 문제 해결
  1. ### 데이터 저장 방식
     - 문제점 : OPEN API의 대량의 데이터를 어떻게 데이터베이스와 연결을 하고 한번에 저장을 할까?
     - 해결 방법 :
       1. 디버깅을 하면서 데이터가 어떻게 넘어오는지 이해를 하려 했다.
       2. JSON 객체 안에 ITEM요소에 데이터들이 있다는 것을 알게 되었고 이 ITEM까지 접근한 뒤 필요한 데이터만 VO에 담았다.
          
          ![image](https://github.com/user-attachments/assets/e40f96ff-c44b-4f35-9e0e-7c744cd48c52)

       4. 대량의 데이터들이 들어있는 VO를 mapper까지 전달하였고 Mybatis의 foreach문을 사용하여 대량의 데이터를 한번에 저장할 수 있었다.

          ![image](https://github.com/user-attachments/assets/dfe6dbc9-4b42-4392-bd70-b978a066dbda)

  ---
  
  2. ### 플래너 저장 (플랜 추가 버튼) 
     - 문제점 : 플래너 저장 페이지에서 검색해서 나온 List의 + 버튼을 눌렀을 때 plan영역으로 데이터를 보내려 했지만 구문 오류라 값이 넘어가지를 않았다.
     - 해결 방법 :
       1. 보내려는 값이 객체 형태이기 떄문에 다른 div로 바로 넘길 수가 없었다.
      
          ![image](https://github.com/user-attachments/assets/26a532b3-0d88-416e-9061-376a7da3e422)

       2. 데이터가 들어있는 item을 JSON.Stringify 함수를 사용해서 객체를 json형식으로 바꿔주었고 정상적으로 값이 전달될 수 있었다.
    
          ![image](https://github.com/user-attachments/assets/f46c0387-914f-4796-afa3-f68430250f47)
          ![image](https://github.com/user-attachments/assets/63bb6b27-7711-4a05-a90d-c9de4d02a67b)
      
       3. 이 전달받은 데이터를 통해 지도에 마커를 찍는 기능, 마커와 마커사이 선긋기 기능을 넣었고, plan영역의 활성화 되어있는 div 속성명에 전달받은 데이터들의 값을 넣어주었다.
          
 ---
 
 3. ### 플래너 저장 (플랜 저장 버튼)
    - 문제점 : 여러 개의 plan 데이터와 모달에서 입력했던 데이터를 저장 버튼을 누를 시 어떻게 Controller에 전달할까?
    - 해결 방법 :
      
      ![image](https://github.com/user-attachments/assets/d98c3b93-e052-4001-8ebf-06ad3944925a)

      1. 모달에서 입력했던 데이터는 hidden으로 숨기고 값을 받아올 수 있었다.
      2. plan 데이터는 each문을 사용하여 여러 일정의 데이터를 attr과 find를 사용하여 받아올 수 있었다.
      3. 모달에서 입력했던 데이터는 planner로 묶어주었고 일정들의 데이터는 planList로 묶어주었다
      4. planList와 planner를 하나로 묶어주었고 json화 시켜 AJax로 Controller로 보내주었다.
     
 ---
     
4. ### 플래너 저장 (플랜 저장)

      ![image](https://github.com/user-attachments/assets/48ac6ca6-9480-4fb1-a9fd-16c3b1cdda34)

     - 문제점 : 두 테이블을 한번에 저장하다 보니 planner와 plan-data 테이블을 연결 시켜줄 시퀀스가 아직 뽑히지 않은 상태이기 때문에 연결 시켜줄 방법이 없었음
     - 문제 해결 :
       
       ![image](https://github.com/user-attachments/assets/a49d4f85-f4fd-4306-b28f-06bcad4bb3fa)

       planner를 삽입하기 전에 시퀀스 값을 미리 뽑아와 plannerNo에 삽입시켰고 이로 인해 두 테이블을 연결 시켜줄 수 있었다.





