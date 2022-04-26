#  Reposearch
Github Repository Search for iOS


## 기본 사항 적용
- 디바이스 제한: 아이폰 (portrait only)
- 최소 지원 버전: iOS 12.0
- Scheme: Debug, Test, QA, Staging, Release
    - 가변 앱 이름, ID 적용, 빌드 트랙 분리
- 로컬라이징: English, Korean
- Scene 미사용
- 다크모드 미사용
- 코어 라이브러리
    - RxSwift: 반응형 코드 작업
    - R.swift: 리소스 사용
    - Alamofire: 네트워크


## 1차 스프린트 작업
- 목표 사항: 앱 기능의 기본적인 최소 요구사항 구현 
    - 도메인 영역을 제외한 데이터 + 뷰 영역 기본 작업
    - API의 검색어 패러미터만 작업
- 작업 특이사항
    - github api 타임아웃 10초 제한
