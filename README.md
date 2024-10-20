# Happy Bean Donation Site ☘️  
공익 기부 프로젝트를 위한 웹사이트  


<br><br>  


## 1. Project Overview (프로젝트 개요)  


- **프로젝트 이름**: 해피빈 기부 사이트  


- **프로젝트 설명**: 공익 기부 프로젝트를 위한 웹사이트  


<br><br>  


## 2. Tasks & Responsibilities (작업 및 역할 분담)

### 이예림
- **UI**:
  - 페이지: 기부 페이지, 기부 관리자 페이지, 공지사항 메인 페이지, 펀딩 결제 페이지
  - 공통 컴포넌트: 기부 리스트, 공지사항 카드, 결제 버튼
- **기능**:
  - 기부 목록 조회, 기부 프로젝트 등록 및 관리, 공지사항 작성 및 수정, 결제 프로세스 구현

### 김혜진
- **UI**:
  - 페이지: 메인 페이지, 펀딩 페이지, 캠페인 페이지, 로그인 및 회원가입 페이지
  - 공통 컴포넌트: 탐색 바, 필터링 옵션, 사용자 정보 입력 폼
- **기능**:
  - 사용자 인증, 로그인 및 회원가입 로직, 캠페인 관리 기능

### 한치영
- **UI**:
  - 페이지: 모금함 페이지
  - 공통 컴포넌트: 모금 진행률 바, 기부 카드 컴포넌트
- **기능**:
  - 기부 등록 및 관리, 펀딩 결제 로직, 로그인 및 회원가입 기능

### 장태욱
- **UI**:
  - 페이지: 공지사항 상세 페이지, 공지사항 관리자 페이지
- **기능**:
  - 공지사항 작성 및 관리 기능, 공지사항 수정 및 삭제




<br><br>  


## 3. Key Features (주요 기능)  


- **회원가입**  
  - 회원가입 시 사용자 정보가 DB에 등록됩니다.  


<br>  


- **로그인**  
  - 사용자 인증 정보를 통해 로그인할 수 있습니다.  


<br>  


- **기부,펀딩 프로젝트 탐색**  
  - 사용자는 현재 진행 중인 기부 프로젝트 목록을 탐색하고, 각 프로젝트의 상세 내용을 확인할 수 있습니다.  


<br>  


- **기부,펀딩 내역 확인**  
  - 기부한 내역과 완료된 기부 프로젝트를 조회할 수 있습니다.

 
<br>  


- **기부,펀딩 목표 달성 시 종료**  
  - 프로젝트의 기부 목표 금액이 달성되면 자동으로 종료됩니다.

 
<br>  


- **보유 금액, 후원한 금액, 후원 기록 확인**  
  - 사용자는 자신의 보유 금액, 후원한 금액, 그리고 후원 내역을 확인할 수 있습니다.
 

<br>  


- **관리자 모드 (목록 수정, 삭제, 추가)**  
  - 관리자는 관리자 모드에서 기부 목록을 수정, 삭제, 추가할 수 있습니다.



<br><br>  


## 4. Tech Stack (기술 스택)

### Frontend
![HTML](https://img.shields.io/badge/HTML-E34F26?style=for-the-badge&logo=html5&logoColor=white)
![CSS](https://img.shields.io/badge/CSS-1572B6?style=for-the-badge&logo=css3&logoColor=white)
![SCSS](https://img.shields.io/badge/SCSS-CC6699?style=for-the-badge&logo=sass&logoColor=white)
![JavaScript](https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black)

### Backend
![Java](https://img.shields.io/badge/Java-007396?style=for-the-badge&logo=java&logoColor=white)
![JSP](https://img.shields.io/badge/JSP-007396?style=for-the-badge&logo=java&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)

### Tools
![Eclipse](https://img.shields.io/badge/Eclipse-2C2255?style=for-the-badge&logo=eclipse&logoColor=white)
![Visual Studio Code](https://img.shields.io/badge/VS%20Code-007ACC?style=for-the-badge&logo=visual-studio-code&logoColor=white)
![Apache Tomcat](https://img.shields.io/badge/Tomcat-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)



<br><br>  


## 5. Project Structure (프로젝트 구조)

```
Happypotato/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   ├── board/          # 게시판 관련 Java 클래스
│   │   │   ├── Controls/       # 펀딩, 캠페인 관련 Java 클래스
│   │   │   ├── donation/       # 기부 관련 Java 클래스
│   │   │   └── join/           # 회원가입 관련 Java 클래스
│   │   ├── webapp/
│   │       ├── admin/          # 관리자 페이지 관련 파일
│   │       ├── css/            # 스타일시트 파일 (CSS)
│   │       ├── font/           # 폰트 파일
│   │       ├── images/         # 이미지 파일들
│   │       ├── join/           # 회원가입 관련 파일
│   │       ├── js/             # JavaScript 파일들
│   │       ├── my/             # 사용자 관련 파일
│   │       ├── payment/        # 결제 관련 JSP 파일
│   │       ├── sql/            # SQL 쿼리 파일
│   │       ├── sub/            # 서브 페이지 관련 JSP 파일
│   │       │   ├── campaign/   # 캠페인 관련 파일
│   │       │   ├── donation/   # 기부 관련 파일
│   │       │   ├── funding/    # 펀딩 관련 파일
│   │       │   ├── fundrasing/ # 모금함 관련 파일
│   │       │   └── notice/     # 공지사항 관련 파일
│   │       ├── views/          # 여러 페이지에서 공통으로 사용되는 템플릿 파일
│   │       ├── WEB-INF/        # 웹 애플리케이션의 설정 및 보안 파일들
│   │       └── index.jsp       # 메인 페이지 파일
└── README.md                   # 프로젝트 설명 파일
