Area.create!(
  [
    {id: 1, area_name: '北海道'},
    {id: 2, area_name: '東北'},
    {id: 3, area_name: '関東'},
    {id: 4, area_name: '甲信越・北陸'},
    {id: 5, area_name: '東海'},
    {id: 6, area_name: '関西'},
    {id: 7, area_name: '中国・四国'},
    {id: 8, area_name: '九州'},
    {id: 9, area_name: '沖縄'}
  ]
)
Pref.create!(
  [
    {id: 1, pref_id:'01', pref_name:'北海道',area_id: 1},

    {id: 2, pref_id:'02', pref_name:'青森県',area_id: 2},
    {id: 3, pref_id:'03', pref_name:'岩手県',area_id: 2},
    {id: 4, pref_id:'04', pref_name:'宮城県',area_id: 2},
    {id: 5, pref_id:'05', pref_name:'秋田県',area_id: 2},
    {id: 6, pref_id:'06', pref_name:'山形県',area_id: 2},
    {id: 7, pref_id:'07', pref_name:'福島県',area_id: 2},

    {id: 8, pref_id:'08', pref_name:'茨城県',area_id: 3},
    {id: 9, pref_id:'09', pref_name:'栃木県',area_id: 3},
    {id: 10, pref_id:'10', pref_name:'群馬県',area_id: 3},
    {id: 11, pref_id:'11', pref_name:'埼玉県',area_id: 3},
    {id: 12, pref_id:'12', pref_name:'千葉県',area_id: 3},
    {id: 13, pref_id:'13', pref_name:'東京都',area_id: 3},
    {id: 14, pref_id:'14', pref_name:'神奈川県',area_id: 3},     

    {id: 15, pref_id:'15', pref_name:'新潟県',area_id: 4},
    {id: 16, pref_id:'16', pref_name:'富山県',area_id: 4},
    {id: 17, pref_id:'17', pref_name:'石川県',area_id: 4},
    {id: 18, pref_id:'18', pref_name:'福井県',area_id: 4},
    {id: 19, pref_id:'19', pref_name:'山梨県',area_id: 4},
    {id: 20, pref_id:'20', pref_name:'長野県',area_id: 4},

    {id: 21, pref_id:'21', pref_name:'岐阜県',area_id: 5},
    {id: 22, pref_id:'22', pref_name:'静岡県',area_id: 5},
    {id: 23, pref_id:'23', pref_name:'愛知県',area_id: 5},
    {id: 24, pref_id:'24', pref_name:'三重県',area_id: 5},

    {id: 25, pref_id:'25', pref_name:'滋賀県',area_id: 6},
    {id: 26, pref_id:'26', pref_name:'京都府',area_id: 6},
    {id: 27, pref_id:'27', pref_name:'大阪府',area_id: 6},
    {id: 28, pref_id:'28', pref_name:'兵庫県',area_id: 6},
    {id: 29, pref_id:'29', pref_name:'奈良県',area_id: 6}, 
    {id: 30, pref_id:'30', pref_name:'和歌山県',area_id: 6}, 

    {id: 31, pref_id:'31', pref_name:'鳥取県',area_id: 7},
    {id: 32, pref_id:'32', pref_name:'島根県',area_id: 7},
    {id: 33, pref_id:'33', pref_name:'岡山県',area_id: 7},
    {id: 34, pref_id:'34', pref_name:'広島県',area_id: 7},
    {id: 35, pref_id:'35', pref_name:'山口県',area_id: 7}, 
    {id: 36, pref_id:'36', pref_name:'徳島県',area_id: 7}, 
    {id: 37, pref_id:'37', pref_name:'香川県',area_id: 7}, 
    {id: 38, pref_id:'38', pref_name:'愛媛県',area_id: 7}, 
    {id: 39, pref_id:'39', pref_name:'高知県',area_id: 7}, 

    {id: 40, pref_id:'40', pref_name:'福岡県',area_id: 8},
    {id: 41, pref_id:'41', pref_name:'佐賀県',area_id: 8},
    {id: 42, pref_id:'42', pref_name:'長崎県',area_id: 8},
    {id: 43, pref_id:'43', pref_name:'熊本県',area_id: 8},
    {id: 44, pref_id:'44', pref_name:'大分県',area_id: 8}, 
    {id: 45, pref_id:'45', pref_name:'宮崎県',area_id: 8}, 
    {id: 46, pref_id:'46', pref_name:'鹿児島県',area_id: 8},

    {id: 47, pref_id:'47', pref_name:'沖縄県',area_id: 9}
  ] 
)