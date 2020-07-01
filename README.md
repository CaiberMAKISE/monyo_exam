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