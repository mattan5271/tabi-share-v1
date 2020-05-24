# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: 'admin@admin', password: 'adminadmin')

Scene.create(name: 'デート')

# 多階層ジャンル
themepark = Genre.create(name: 'テーマパーク')
themepark_play = themepark.children.create(name: '遊び')
themepark_learn = themepark.children.create(name: '学び')
themepark_food = themepark.children.create(name: '食')
themepark_play.children.create([{ name: 'すべて' }, { name: '屋外' }, { name: '室内' }])
themepark_learn.children.create([{ name: 'すべて' }, { name: '屋外' }, { name: '室内' }])
themepark_food.children.create([{ name: 'すべて' }, { name: '屋外' }, { name: '室内' }])

leisureland = Genre.create(name: 'レジャーランド')
leisureland_animal = leisureland.children.create(name: '動物園')
leisureland_fish = leisureland.children.create(name: '水族館')
leisureland_animal.children.create([{ name: 'すべて' }, { name: '屋外' }, { name: '室内' }])
leisureland_fish.children.create([{ name: 'すべて' }, { name: '屋外' }, { name: '室内' }])
