# README
___

- ## DataBase Design
### Tables

- ### users table
    |Column|Type|Options|
    |------|----|-------|
    |name|string|null: false, index: true|
    |email|string|null: false, unique: true|
    |devise columns||
    ##### Association
    - has_many :users_groups
    - has_many :groups, through: :users_groups
    - has_many :messages
---

- ### groups table
    |Column|Type|Options|
    |------|----|-------|
    |name|string|null: false|
    ##### Association
    - has_many :users_groups
    - has_many :users, through: :users_groups
    - has_many :messages
---

- ### users_groups table
    |Column|Type|Options|
    |------|----|-------|
    |user|references|null: false, foreign_key: true|
    |group|references|null: false, foreign_key: true|
    ##### Association
    - belongs_to :user
    - belongs_to :group
---

- ### messages table
    |Column|Type|Options|
    |------|----|-------|
    |body|text||
    |image|string||
    |user|references|null: false, foreign_key: true|
    |group|references|null: false, foreign_key: true|
    ##### Association
    - belongs_to :user 
    - belongs_to :group