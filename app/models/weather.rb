class Weather < ActiveHash::Base
  self.data =[
    {id: 1, name: '晴れ'}, {id: 2, name: '曇り'}, {id: 3, name: '小雨'},
    {id: 4, name: '雨'}, {id: 5, name: '雪'}
  ]
end