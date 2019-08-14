# README
___

- ## DataBase Design
### Tables

- ### users table
    |Column|Type|Options|
    |------|----|-------|
    |name|string|null: false|
    |email|string|null: false, unique: true|
    |devise columns||
    ##### Association
    - has_many :users_groups
    - has_many :groups, through: :users_groups
    - has_many :messages
    ##### Index
    - name, email
---

- ### groups table
    |Column|Type|Options|
    |------|----|-------|
    |group_name|string|null: false|
    ##### Association
    - has_many :users_groups
    - has_many :users, through: :users_groups
    ##### Index
    - none
---

- ### users_groups table
    |Column|Type|Options|
    |------|----|-------|
    |user_id|integer|null: false, foreign_key: true|
    |group_id|integer|null: false, foreign_key: true|
    ##### Association
    - belongs_to :users
    - belongs_to :groups
    ##### Index
    - none
---

- ### messages table
    |Column|Type|Options|
    |------|----|-------|
    |body|text||
    |image|string||
    |group_id|integer|null: false, foreign_key: true|
    |user_id|integer|null: false, foreign_key: true|
    ##### Association
    - belongs_to :user 
    - belongs_to :group
    ##### Index
    - none