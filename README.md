# AutoComplete
## 언어 : Swift
## Based on Realm

---
### 데이터를 받으면 각 데이터를 분류해줌
### 음소가모여 음절이되는 언어인 한글도 분류할수있도록 음소단위로 끊어서 분리함
---
### 사용예시
<img src = "https://user-images.githubusercontent.com/62425964/98548099-753ccb00-22dc-11eb-8510-7da8e7a3cc60.jpeg" height="300px" width ="150px"> </img> <img src = "https://user-images.githubusercontent.com/62425964/98548113-78d05200-22dc-11eb-95c1-2827110cdeea.jpeg" height="300px" width ="150px"> </img> <img src = "https://user-images.githubusercontent.com/62425964/98548134-7cfc6f80-22dc-11eb-8574-ff7c542d781a.jpeg" height = "300px" width= "150px"> </img> <img src = "https://user-images.githubusercontent.com/62425964/98548156-81288d00-22dc-11eb-80f5-c180382e7a3e.jpeg" height = "300px" width= "150px"> </img>

---
> ## 시간복잡도
> > ### find = O(쿼리의 value갯수)
> > ### 데이터 구조 생성 = O(데이터 길이 * 데이터의 가장긴 문자열)
> ## 동작
> > ### 데이터를 한글자씩 분류해서 [key:value]형태로 저장
> > ### 한번 데이터를 입력받으면, 바뀌기전까지 데이터 구조를 재생성하지않음
> ## 저장되는 데이터 구조
> > ### DataSet { key : String! Value : String! } 
> > ### CusomData { key : String! Value : String! User : Bool }
> ## 초기 세팅
> > ### CocoaPods 설치
> > ### 사용할 프로젝트에 Realm설치
> > ### 깃 폴더에서 DataStructure.swift 복붙
> ## 사용법
> > ### DataSet -> 사용자의 활동에 따라 변하지 않는 데이터 (초기 설정 데이터 저장)
> > #### DataSet 초기 데이터 셋팅 하기
> > > #### DataFrame().GetData(data : Array<String>)
> > ### CustomData -> 사용자의 활동에 따라 변하는 데이터 (ex) 검색 목록 저장등)
> > > #### DataFrame().PutData(data : String)
> > ### key값 찾기
> > #### DataSet, CustomData에서 원하는 key값에 해당하는 Value들을 찾아줌 반환형은 [String]
> > #### CustomData를 우선으로 찾음
> > > #### DataFrame().FindData(filter: String)
> > ### Data삭제
> > #### CustomData만 삭제해줌 (DataSet은 데이터 값이 변경되면 자동으로 업데이트함)
> > > #### DataFrame().DeleteData()
