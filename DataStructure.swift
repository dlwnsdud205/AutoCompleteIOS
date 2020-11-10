//
//  CreateData.swift
//  AutoComplete
//
//  Created by 이준영 on 2020/11/07.
//

import UIKit
import RealmSwift

class DataSet: Object{
    @objc dynamic var key: String!
    @objc dynamic var value: String!
}

class CustomData: Object{
    @objc dynamic var key: String!
    @objc dynamic var value: String!
    @objc dynamic var User = true
}

class DataFrame{
    
    func GetData(data: [String]) -> Void{
        var DataSize : CUnsignedLongLong = 0;
        for i in 0..<data.count{
            DataSize = DataSize+UInt64(data[i].count)
        }
        if(DataSize != UserDefaults.standard.integer(forKey: "DataSize")){
            let Data = try! Realm()
            let dataset = Data.objects(DataSet.self)
            try! Data.write{
                Data.delete(dataset)
            }
            UserDefaults.standard.setValue(DataSize, forKey: "DataSize")
            for i in 0..<data.count{
                var IndexingComplete = DataIndexing(data: data[i])
                for j in 0..<IndexingComplete.count{
                    let dataset: DataSet = DataSet()
                    dataset.key = IndexingComplete[j][data[i]]
                    dataset.value = data[i]
                    let Data = try! Realm()
                    try! Data.write{
                        Data.add(dataset)
                    }
                }
            }
        }
    }
    
    func PutData(data: String) -> Void{
        var IndexingComplete = DataIndexing(data: data)
        for i in 0..<IndexingComplete.count{
            let customdata: CustomData = CustomData()
            customdata.key = IndexingComplete[i][data]
            customdata.value = data
            customdata.User = true
            let Custom = try! Realm()
            try! Custom.write{
                Custom.add(customdata)
            }
        }
    }
    
    func DeleteData(){
        let Data = try! Realm()
        let Custom = Data.objects(CustomData.self)
        try! Data.write{
            Data.delete(Custom)
        }
    }
    
    // MARK: - Initial data
    // MARK: - Indexing
    func DataIndexing(data: String!) -> Array<[String: String]>{
        var str = ""
        let value = data
        var IndexingArray : Array<[String: String]> = []
        for i in 0..<data.count{
            let end_idx = data.index(data.startIndex, offsetBy: i)
            if(UnicodeScalar(String(data[end_idx...end_idx]))!.value >= 0xAC00 && UnicodeScalar(String(data[end_idx...end_idx]))!.value <= 0xD7A3){
                // MARK: - 한글 인덱싱
                let 초성 = (((UnicodeScalar(String(data[end_idx...end_idx]))!.value) - 0xAC00) / 28) / 21
                let 중성 = (((UnicodeScalar(String(data[end_idx...end_idx]))!.value) - 0xAC00) / 28) % 21
                let 종성 = ((UnicodeScalar(String(data[end_idx...end_idx]))!.value) - 0xAC00) % 28
                //0xAC00 + 28 * 21 * (초성) + 28 * (중성) + (종성)
                let KeyData = String(UnicodeScalar(초성+0x1100)!)
                str = str + String(UnicodeScalar(초성+0x1100)!)
                IndexingArray.append([value! : str])
                str = str + String(UnicodeScalar(중성 + 0x1161)!)
                IndexingArray.append([value! : str])
                if(종성 != 0){
                    str = str + String(UnicodeScalar(종성 + 0x11a6+1)!)
                    IndexingArray.append([value! : str])
                }
                // MARK: - 한글 인덱싱 종료
            }
            else{
                // MARK: - English indexing
                str = str + String(data[end_idx...end_idx])
                var key = String(data[...end_idx])
                IndexingArray.append([value! : str])
                //PutData(key: key, value: data)
                // MARK: - English indexing end
            }
        }
        return IndexingArray
    }
    // MARK: -Indexing end
    // MARK: -Initial data end
    
    func FindData(filter : String!) -> Array<String>{
        var fil = ""
        let Data = try! Realm()
        for i in 0..<filter.count{
            let idx = filter.index(filter.startIndex, offsetBy: i)
            if(UnicodeScalar(String(filter[idx...idx]))!.value >= 0xAC00 && UnicodeScalar(String(filter[idx...idx]))!.value <= 0xD7A3){
                let 초성 = (((UnicodeScalar(String(filter[idx...idx]))!.value) - 0xAC00) / 28) / 21
                let 중성 = (((UnicodeScalar(String(filter[idx...idx]))!.value) - 0xAC00) / 28) % 21
                let 종성 = ((UnicodeScalar(String(filter[idx...idx]))!.value) - 0xAC00) % 28
                fil = fil + String(UnicodeScalar(초성+0x1100)!)
                fil = fil + String(UnicodeScalar(중성 + 0x1161)!)
                if(종성 != 0){
                    fil = fil + String(UnicodeScalar(종성 + 0x11a6+1)!)
                }
            }
            else if(UnicodeScalar(String(filter[idx...idx]))! >= UnicodeScalar("ㄱ") && UnicodeScalar(String(filter[idx...idx]))! <= UnicodeScalar("ㅎ")){
                fil = fil + CUni[String(filter[idx...idx])]!
            }
            else{
                fil = fil + filter[idx...idx]
            }
        }
        let Query = "key = '\(fil)'"
        var ResultArray : Array<String> = []
        ResultArray = ResultArray + DataReprocessing(data : Array(Data.objects(DataSet.self).filter(Query)), userdata: Array(Data.objects(CustomData.self).filter(Query)))
        return ResultArray
    }
    
    func DataReprocessing(data : Array<DataSet>, userdata: Array<CustomData>) -> Array<String>{
        var ResultArray : Array<String> = []
        for i in 0..<userdata.count{
            ResultArray.append(userdata[i].value(forKey: "value") as! String)
        }
        for i in 0..<data.count{
            ResultArray.append(data[i].value(forKey: "value") as! String)
        }
        if(ResultArray.count == 0){
            return[""]
        }
        return ResultArray
    }
    
    
    
    let CUni : [String : String] = ["ㄱ":"\u{1100}", "ㄲ" : "\u{1101}", "ㄴ" : "\u{1102}", "ㄷ" : "\u{1103}", "ㄸ" : "\u{1104}","ㄹ": "\u{1105}", "ㅁ" : "\u{1106}", "ㅂ" : "\u{1107}", "ㅃ" : "\u{1108}", "ㅅ" : "\u{1109}", "ㅆ" : "\u{110a}", "ㅇ" : "\u{110b}" , "ㅈ" : "\u{110c}" , "ㅉ" : "\u{110d}", "ㅊ" : "u{110e}", "ㅋ" : "\u{110f}", "ㅌ":"\u{1110}", "ㅍ":"\u{1111}" ,"ㅎ":"\u{1112}"]
    
}
