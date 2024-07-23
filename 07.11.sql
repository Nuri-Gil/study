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


-- 07.15 tbl_reply 테이블부터 생성
create table tbl_reply
(
    rno        int auto_increment primary key,
    bno        int           not null,
    replyText  varchar(2000) not null,
    replyer    varchar(100)  not null,
    regDate    timestamp default now(),
    updateDate timestamp default now(),
    -- FK 지정하는 SQL 문
    constraint fk_reply_board
        foreign key (bno)              -- FK 컬럼 값
            references tbl_board (bno) -- 참조 값
);

select *
from tbl_board
order by bno desc;

update tbl_reply
set replyText  = 'AAA',
    updateDate = now()
where rno = 51
;

-- 인덱스 만들기
CREATE INDEX idx_reply ON tbl_reply (bno desc, rno asc);

select *
from tbl_reply
where bno = 575;

-- 댓글 DB 만들기
SELECT *
FROM tbl_reply;

INSERT INTO tbl_reply (bno, replyText, replyer)
        (SELECT bno, replyText, replyText FROM tbl_reply);

create table tbl_sample1(
    s1  int auto_increment primary key ,
    col varchar(500)
);

create table tbl_sample2(
    s2  int auto_increment primary key ,
    col varchar(50)
);

select *
from tbl_sample1;

select *
from tbl_sample2;


