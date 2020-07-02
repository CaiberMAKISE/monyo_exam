# README
# schema

* User
    | column_name | data_type |
    | ----------- | --------- |
    | id          | integer   |
    | name        | string    |
    | email       | string    |
    | password    | string    |
    | task_id     | integer   |

* Task
    | column_name | data_type |
    | ----------- | --------- |
    | id          | integer   |
    | title       | string    |
    | content     | text      |
    | label_id    | integer   |
    | dead_line   | date      |
    | status      | string    |
    | priority    | integer   |

* Label
    | column_name | data_type |
    | ----------- | --------- |
    | id          | integer   |
    | title       | string    |
    | content     | text      |

* deploy procedure

$ rails assets:precompile RAILS_ENV=production

$ git add .

$ git commit -m "hoge"

$ heroku create

$ heroku buildpacks:set heroku/ruby

$ heroku buildpacks:add --index 1 heroku/nodejs

$ git push heroku master

$ heroku run rails db:migrate