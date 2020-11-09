//
//  ViewController.swift
//  AutoComplete
//
//  Created by 이준영 on 2020/11/07.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate{
    
    var SampleData = ["apple", "auto", "abc", "alphabet", "alphago", "axe", "under", "under the sea", "man", "girl", "가톨릭대학교", "JUNN_0", "ABC초콜릿", "BHC치킨", "이준영", "abstain from ~ing = refrain from ~ing", "accelerate", "acceleration", "accept", "accidently=by chance, unexpectedly", "accommodate", "accomodations", "accompany", "accompanying instructions", "accomplished man", "바이슨 당선", "트럼프VS바이슨"]
    
    override func viewDidLoad() {
        DataFrame().GetData(data: SampleData)
        var TestArray : Array<String> = []
        TestArray.append(contentsOf: DataFrame().FindData(filter: "a"))
        print(DataFrame().FindData(filter: "a"))
        TestArray.append(contentsOf: DataFrame().FindData(filter: "가톨"))
        TestArray.append(contentsOf: DataFrame().FindData(filter: "B"))
        /*
        for i in 0..<TestArray.count{
            print(TestArray)
        }
        */
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(BottomView)
        view.backgroundColor = .white
        SetSearch(Margin: 0)
        self.SearchView.delegate = self
        self.SearchView.placeholder = "Type text!"
    }
    
    var BottomView = UIView()
    var SearchView = UISearchBar()
    var ScrollView = UIScrollView()
    var InScroll = UIView()
    var Inbtn = UIButton()
    var SearchViewSize = 40
    var BtnSize = 40
    let btn_text = UILabel()
    var BTNS : [UILabel] = []
    var BTNV : [UIView] = []
    
    func SetSearch(Margin : CGFloat?){
        var mar = Margin!
        if(Margin! == 0 || Margin == nil){
            mar = CGFloat(1)
        }
        SetBottomView()
        SetScrollView(Margin: mar)
        SetInScroll()
        SetSearchView(Margin: mar)
    }
    
    func SetBottomView(){
        SetShadow(View: BottomView)
        BottomView.layer.cornerRadius = 5
        BottomView.backgroundColor = UIColor.black
        BottomView.alpha = 0.8
        BottomView.translatesAutoresizingMaskIntoConstraints = false
        BottomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(UIScreen.main.bounds.height * (1/6))).isActive = true
        BottomView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(UIScreen.main.bounds.width * (1/8))).isActive = true
        BottomView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: CGFloat(-UIScreen.main.bounds.width * (1/8))).isActive = true
        BottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: CGFloat(-UIScreen.main.bounds.height * (1/4))).isActive = true
    }
    
    func SetScrollView(Margin: CGFloat){
        ScrollView.layer.cornerRadius = 5
        ScrollView.backgroundColor = UIColor.clear
        BottomView.addSubview(ScrollView);
        ScrollView.translatesAutoresizingMaskIntoConstraints = false
        ScrollView.topAnchor.constraint(equalTo: BottomView.topAnchor, constant: CGFloat(SearchViewSize)).isActive = true
        ScrollView.leftAnchor.constraint(equalTo: BottomView.leftAnchor, constant: CGFloat(Margin)).isActive = true
        ScrollView.rightAnchor.constraint(equalTo: BottomView.rightAnchor, constant: CGFloat(-Margin)).isActive = true
        ScrollView.bottomAnchor.constraint(equalTo: BottomView.bottomAnchor).isActive = true
    }
    
    func SetInScroll(){
        InScroll.layer.cornerRadius = 5
        InScroll.backgroundColor = UIColor.clear
        ScrollView.addSubview(InScroll)
        InScroll.translatesAutoresizingMaskIntoConstraints = false
        InScroll.heightAnchor.constraint(equalToConstant: CGFloat(BtnSize * BtnSize)).isActive = true
        InScroll.topAnchor.constraint(equalTo: ScrollView.topAnchor).isActive = true
        InScroll.leftAnchor.constraint(equalTo: ScrollView.leftAnchor).isActive = true
        InScroll.rightAnchor.constraint(equalTo: ScrollView.rightAnchor).isActive = true
        InScroll.bottomAnchor.constraint(equalTo: ScrollView.bottomAnchor).isActive = true
    }
    
    func MakeBtn(array : [String]){
        //InScroll.translatesAutoresizingMaskIntoConstraints = false
        SetBottomView()
        SetInScroll()
        print(array)
        let left_margin : CGFloat = ScrollView.layer.bounds.size.width / 2 -  ScrollView.layer.bounds.size.width / 4
        for i in 0..<BTNS.count{
            BTNS[i].text = ""
            BTNV[i].layer.borderWidth = 0
        }
        InScroll.heightAnchor.constraint(equalToConstant: CGFloat(BtnSize * (array.count) + 5)).isActive = true
        if(BTNS.count < array.count){
            for i in 0..<array.count - BTNS.count{
                BTNS.append(UILabel())
                BTNV.append(UIView())
            }
        }
        if(array.count == 1 && array[0] == ""){
            return;
        }
        for i in 0..<array.count{
            BTNV[i].tintColor = .white
            BTNV[i].backgroundColor = .clear
            BTNV[i].layer.borderColor = UIColor.gray.cgColor
            BTNV[i].layer.borderWidth = 0.3
            InScroll.addSubview(BTNV[i])
            BTNV[i].translatesAutoresizingMaskIntoConstraints = false
            BTNV[i].topAnchor.constraint(equalTo: InScroll.topAnchor, constant: CGFloat(BtnSize*i+5)).isActive = true
            BTNV[i].leftAnchor.constraint(equalTo: InScroll.leftAnchor).isActive = true
            BTNV[i].rightAnchor.constraint(equalTo: InScroll.rightAnchor).isActive = true
            BTNV[i].heightAnchor.constraint(equalToConstant: CGFloat(40)).isActive = true
            BTNV[i].widthAnchor.constraint(equalToConstant: CGFloat(ScrollView.layer.bounds.size.width)).isActive = true
            BTNS[i].text = array[i]
            BTNS[i].textColor = .white
            BTNS[i].textAlignment = NSTextAlignment.left
            BTNS[i].font = UIFont.boldSystemFont(ofSize: CGFloat(14))
            BTNV[i].addSubview(BTNS[i])
            BTNS[i].translatesAutoresizingMaskIntoConstraints = false
            BTNS[i].heightAnchor.constraint(equalTo: BTNV[i].heightAnchor).isActive = true
            BTNS[i].topAnchor.constraint(equalTo: BTNV[i].topAnchor).isActive = true
            BTNS[i].leftAnchor.constraint(equalTo: BTNV[i].leftAnchor, constant: CGFloat(5)).isActive = true
            BTNS[i].rightAnchor.constraint(equalTo: BTNV[i].rightAnchor).isActive = true
        }
    }
    
    func SetSearchView(Margin : CGFloat){
        SearchView.layer.cornerRadius = 5
        SearchView.backgroundColor = UIColor.black
        SearchView.tintColor = UIColor.lightGray
        BottomView.addSubview(SearchView)
        SearchView.translatesAutoresizingMaskIntoConstraints = false
        SearchView.topAnchor.constraint(equalTo: BottomView.topAnchor, constant: CGFloat(5)).isActive = true
        SearchView.leftAnchor.constraint(equalTo: BottomView.leftAnchor, constant: CGFloat(Margin)).isActive = true
        SearchView.rightAnchor.constraint(equalTo: BottomView.rightAnchor, constant: CGFloat(-Margin)).isActive = true
        SearchView.heightAnchor.constraint(equalToConstant: CGFloat(SearchViewSize)).isActive = true
    }
    
    func SetShadow(View: UIView){
        View.layer.shadowColor = UIColor.black.cgColor
        View.layer.masksToBounds = false
        View.layer.shadowOffset = CGSize(width: 1, height : 1)
        View.layer.shadowRadius = 1
        View.layer.shadowOpacity = 0.5
    }
}

