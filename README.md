# README
# schema

* User
    id          integer
    name        string
    email       string
    password    string
    task_id     integer

* Task
    id          integer
    title       string
    content     taxt
    label_id    integer
    dedline     date
    status      string
    priority    integer

* Label
    id          integer
    title       string
    content     text