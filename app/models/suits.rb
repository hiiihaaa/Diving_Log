class Suits < ActiveHash::Base
  self.data = [
      {id: 1, name: 'ウエット'}, {id: 2, name: 'セミドライ'}, {id: 3, name: 'ドライ'},
      {id: 4, name: 'フルスーツ'}, {id: 5, name: 'シーガル'}, {id: 6, name: '〇〇 + ベスト'}
  ]
end