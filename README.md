
<h1 align="center"> 🛴 킥보드 대여 앱 - SWIFT </h1>

<div align="center">
  <img src="https://github.com/user-attachments/assets/184ab84e-1f2d-4755-82da-fb5500ec4304" width="600" />
</div>
<br/>

## 📋 프로젝트 설명
**SWIFT**는 빠르고 간편한 킥보드 대여 서비스를 제공하는 iOS 앱입니다.  
네이버 지도 API를 활용하여 실시간 위치 기반의 킥보드 위치를 시각화하고, 사용자가 마커를 클릭하여 킥보드를 **대여 및 반납**할 수 있도록 구현했습니다.

<br/>

## 📌 프로젝트 개요

- **프로젝트명** : SWIFT  
- **팀명** : 이름이 뭐예요?  
- **프로젝트 기간** : 2025.04.25 ~ 2025.05.02  
- **목표**  
  - 네이버 지도 API를 이용하여 지도를 표시하고 마커를 생성  
  - 마커를 클릭하여 킥보드 대여 및 반납 기능 구현  
  - `UserDefaults`를 이용한 로그인 및 회원가입 기능 구현

<br/>

## 📱 앱 이름의 의미

`SWIFT`는 **'빠른'** 이라는 의미의 형용사로, 킥보드의 빠르고 간편한 이동성을 잘 나타냅니다.  
또한, **iOS 개발에 사용되는 프로그래밍 언어 Swift**와도 연결되어, 이중적인 의미를 담고 있습니다.

<br/>

## 👥 팀원 소개

<table>
  <tr>
    <th>프로필</th>
    <th>이름</th>
    <th>역할</th>
    <th>담당 업무</th>
    <th>GitHub 링크</th>
  </tr>
  <tr>
    <td align="center">
      <a href="https://github.com/heopill">
        <img src="https://github.com/heopill.png" width="100" height="100"/><br/>
      </a>
    </td>
    <td align="center"><b>허성필</b></td>
    <td align="center">🧑‍💼 팀장</td>
    <td>
      - 킥보드 등록 화면 구현 <br/>
      - LaunchView 구현 <br/>
      - README 문서 작성
    </td>
    <td align="center">
      <a href="https://github.com/heopill">heopill</a>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://github.com/h-yoon">
        <img src="https://github.com/h-yoon.png" width="100" height="100"/><br/>
      </a>
    </td>
    <td align="center"><b>김형윤</b></td>
    <td align="center">👤 팀원</td>
    <td>
      - 킥보드 대여 화면 구현 <br/>
      - 와이어 프레임 디자인 제작
    </td>
    <td align="center">
      <a href="https://github.com/h-yoon">h-yoon</a>
    </td>
  </tr>
  <tr>
    <td align="center">
      <a href="https://github.com/ghnn-n">
        <img src="https://github.com/ghnn-n.png" width="100" height="100"/><br/>
      </a>
    </td>
    <td align="center"><b>최규현</b></td>
    <td align="center">👤 팀원</td>
    <td>
      - 로그인 / 회원가입 구현 <br/>
      - 마이페이지 구현 <br/>
      - TabBar 구현 
    </td>
    <td align="center">
      <a href="https://github.com/ghnn-n">ghnn-n</a>
    </td>
  </tr>
</table>


### 🛠️ 공통 작업

- SA(시스템 아키텍처) 작성
- Figma 디자인  
- 스크럼 일지 정리  
- 발표 자료 제작  
- 시연 영상 준비
<br/>

## 📌 개발 환경 (Tech Stack)

- 프론트엔드 → <img src="https://img.shields.io/badge/Swift-F05138?style=flat&logo=Swift&logoColor=white"/>  
  

- 버전 관리 및 협업 저장소 → <img src="https://img.shields.io/badge/GitHub-181717?style=flat&logo=GitHub&logoColor=white"/>  
   

- 스크럼 및 문서 정리 → <img src="https://img.shields.io/badge/Notion-000000?style=flat&logo=Notion&logoColor=white"/>  
  

- 실시간 커뮤니케이션 도구로 사용 → <img src="https://img.shields.io/badge/Slack-4A154B?style=flat&logo=Slack&logoColor=white"/>  <img src="https://img.shields.io/badge/ZEP-FFB400?style=flat&logoColor=white"/>
 

- UI/UX 디자인 제작에 사용 → <img src="https://img.shields.io/badge/Figma-F24E1E?style=flat&logo=Figma&logoColor=white"/>  

<br/>

## 🛠 기술 스택

- **iOS**: 16.6  
- **Xcode**: 16  
- **Language**: Swift 5  
- **UI Framework**: UIKit  
- **Layout**: SnapKit  
- **Networking**: Alamofire  
- **Local Data Persistence**: CoreData, UserDefaults

<br/>
  
## 🌳 브랜치 구조
```
main                  ← 최종 배포 브랜치
└── dev               ← 통합 개발 브랜치
    ├── Feat/#1       ← 이슈 넘버 1 개발 브랜치
    ├── Feat/#2       ← 이슈 넘버 2 개발 브랜치
    ├── Feat/#3       ← 이슈 넘버 3 개발 브랜치
    ├── Feat/#4       ← 이슈 넘버 4 개발 브랜치
    └── ...           ← 이후 기능 브랜치들
```
<br/>

## 📝 커밋 컨벤션

### ✅ 기본 규칙

- **⚠️ 모든 커밋에 [Tag] #issueNumber 작성 - 구현 내용 작성**

> 예시  
> `- ex) [Feat] #issueNumber - 홈 뷰를 추가`

### 🔖 커밋 타입 정리

| 타입        | 설명 |
|-------------|------|
| `feat`      | 새로운 기능 추가 |
| `fix`       | 버그 수정 |
| `build`     | 빌드 관련 파일 수정 또는 패키지 매니저 설정 변경 |
| `chore`     | 자잘한 수정 (빌드, 설정 파일 수정 등) |
| `ci`        | CI 설정 관련 수정 |
| `docs`      | 문서 수정 (README 등) |
| `style`     | 코드 포맷팅, 세미콜론 누락 등 기능에 영향 없는 수정 |
| `refactor`  | 코드 리팩토링 (기능 변화 없이 구조 개선) |
| `test`      | 테스트 코드 추가 및 수정 |

<br/>

## 📱 오더ㅋ 목업 이미지

<p align="center">
  <img src="https://github.com/user-attachments/assets/eaac6d80-4676-479c-92c3-a3a982753127" width="45%"/>
  <img src="https://github.com/user-attachments/assets/ae97e746-5990-4f90-9d46-936c03e45e9f" width="45%"/>
</p>


<br/>

## 🎨 사용한 컬러 & 폰트

### ✅ Color Palette

<table>
  <thead>
    <tr>
      <th>이름</th>
      <th>컬러 샘플</th>
      <th>HEX 코드</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><strong>Main Color</strong></td>
      <td align="center">
        <img src="https://github.com/user-attachments/assets/ebb3abf1-a990-4c9a-a956-69e739fec20d" width="40" height="40">
      </td>
      <td><code>#1DCD9F</code></td>
    </tr>
    <tr>
      <td><strong>Sub Color</strong></td>
      <td align="center">
        <img src="https://github.com/user-attachments/assets/7635533a-59bb-4a3e-a79a-8a8343f41066" width="40" height="40">
      </td>
      <td><code>#169976</code></td>
    </tr>
  </tbody>
</table>

> 💡 <strong>Main Color</strong>는 전체 UI의 핵심 포인트로 사용되며,  
> <strong>Sub Color</strong>는 보조 강조 요소에 사용됩니다.

### ✅ Font

| 폰트 이름         | 비고         |
|------------------|--------------|
| **나눔스퀘어 네오**  | 본문 및 일반 UI 텍스트에 사용 |


> 💡 모든 폰트는 프로젝트 내에 임베딩되어 있으며,  
> 가독성과 친근한 분위기를 고려해 선정하였습니다.

#### 🔠 폰트 적용 예시

<img width="458" height="140" alt="폰트 예시 1" src="https://github.com/user-attachments/assets/915d3cdc-52d4-4d74-bbaf-b11d8cf4054a" />


<br/>
<br/>

## ✅ 새롭게 사용한 UIKit 컴포넌트

| 컴포넌트                   | 용도 설명 |
|----------------------------|------------------------------------------------------------------|
| `UITabBarController`       | 하단 탭 바를 통해 주요 화면(Home, 지도, 내 정보 등)을 전환하기 위해 사용. |
| `NMFMapView`               | 네이버 지도 SDK의 핵심 지도 뷰로, 킥보드 위치를 시각화하는 데 사용. |
| `CLLocationManagerDelegate` | 사용자 위치 추적을 위한 Core Location의 델리게이트로, 실시간 위치 업데이트에 사용. |
| `NMFMapViewTouchDelegate`  | 지도 위의 마커 터치 이벤트(대여/반납)를 처리하기 위해 사용. |

> 💡 UI 요소는 **재사용성**과 **모듈화**를 고려해 구성하였습니다.




