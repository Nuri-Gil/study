select now();

create table tbl_board
(
    bno        int auto_increment primary key,
    title      varchar(500)  not null,
    content    varchar(2000) not null,
    writer     varchar(100)  not null,
    regDate    timestamp default now(),
    updateDate timestamp default now()
);

insert into tbl_board (title, content, writer)
values ('Test', 'Test Content', 'user00');

select *
from tbl_board;

select *
from tbl_board
order by bno desc
limit 10, 10;

select count(*)
from tbl_board;

insert into tbl_board (title, content, writer)
select title, content, writer
from tbl_board;

create table temp_table
(
    bno        int auto_increment primary key,
    title      varchar(500)  not null,
    content    varchar(2000) not null,
    writer     varchar(100)  not null,
    regDate    timestamp default now(),
    updateDate timestamp default now()
);

insert into temp_table (title,
                        content,
                        writer,
                        regDate,
                        updateDate)
select title,
       content,
       writer,
       regDate,
       updateDate
from tbl_board;

drop table tbl_board;
alter table temp_table rename tbl_board;
