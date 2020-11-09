# AutoComplete
## 언어 : Swift
## Based on Realm

> ## 시간복잡도
> > ### find 연산 = O(1)
> > ### 데이터 구조 생성 = O(데이터 길이 * 데이터의 가장긴 문자열)
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
> > #### DataSet, CustomData에서 원하는 key값에 해당하는 Value를 찾아줌
> > #### CustomData를 우선으로 찾음
> > > #### DataFrame().FindData(filter: String)
> ## 사용예
> > ### <img src = "https://user-images.githubusercontent.com/62425964/98548099-753ccb00-22dc-11eb-8510-7da8e7a3cc60.jpeg"> </img>
