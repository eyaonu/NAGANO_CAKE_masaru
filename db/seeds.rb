#Admin.create!(
  #email: "aa@aa",
  #password: "000000"
  #)
  
  Genre.create!(
    [
      {
        name: "ケーキ各種"
      },
      {
        name: "焼き菓子(クッキー等)"
      },
      {
        name: "洋菓子(シュークリーム等)"
      },
      {
        name: "生洋菓子(プリン等)"
      },
      {
        name: "贈答品・ギフト向け"
      }
    ]
  )

# Item.create!(
#   [
#     {
#       genre_id: 1,
#       name: "ショートケーキ",
#       description: "！\n",
#       non_taxed_price: 300,
#       sales_status: 0,
      
#     },
#     {
#       genre_id: 1,
#       name: "○○ケーキ",
#       description: "！\n",
#       non_taxed_price: 300,
#       sales_status: 0,
#     },
#     {
#       genre_id: 1,
#       name: "○○ケーキ",
#       description: "\n",
#       non_taxed_price: 300,
#       sales_status: 0,
#     },
#     {
#       genre_id: 1,
#       name: "○○ケーキ",
#       description: "にどうぞ！\nです。",
#       non_taxed_price: 300,
#       sales_status: 0,
#     }
#   ]
# )