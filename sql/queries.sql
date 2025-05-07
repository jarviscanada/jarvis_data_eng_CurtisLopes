--Question 1:
INSERT INTO cd.facilities
    (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
    values (9, 'Spa', 20, 30, 100000, 800);

--Question 2:
INSERT INTO cd.facilities (
    facid, name, membercost, guestcost,
    initialoutlay, monthlymaintenance
)
values
    (9, 'Spa', 20, 30, 100000, 800);

--Question 3:
UPDATE cd.facilities
    SET initialoutlay = 10000
    WHERE facid = 1;

--Question 4:
UPDATE cd.facilities facs
SET
    membercost = (
        select membercost * 1.1
        from cd.facilities
        where facid = 0
    ),
    guestcost = (
        select guestcost * 1.1
        from cd.facilities
        where facid = 0
    )
WHERE
    facs.facid = 1;

--Question 5:
DELETE FROM cd.bookings;

--Question 6:
DELETE FROM
  cd.members
WHERE
  memid = 37;

--Question 7:
select
  facid,
  name,
  membercost,
  monthlymaintenance
from
  cd.facilities
where
  membercost > 0
  and (
    membercost < monthlymaintenance / 50.0
  );

--Question 8:
select
  *
from
  cd.facilities
where
  name like '%Tennis%'

--Question 9:
select
  *
from
  cd.facilities
where
  facid in (1, 5);

--Question 10:
select
  memid,
  surname,
  firstname,
  joindate
from
  cd.members
where
  joindate >= '2012-09-01';

--Question 11:
select
  surname
from
  cd.members
union
select
  name
from
  cd.facilities;

--Question 12:
select
  bks.starttime
from
  cd.bookings bks
  inner join cd.members mems on mems.memid = bks.memid
where
  mems.firstname = 'David'
  and mems.surname = 'Farrell';

--Question 13:
select
  bks.starttime as start,
  facs.name as name
from
  cd.facilities facs
  inner join cd.bookings bks on facs.facid = bks.facid
where
  facs.name in (
    'Tennis Court 2', 'Tennis Court 1'
  )
  and bks.starttime >= '2012-09-21'
  and bks.starttime < '2012-09-22'
order by
  bks.starttime;

--Question 14:
select
  mems.firstname as memfname,
  mems.surname as memsname,
  recs.firstname as recfname,
  recs.surname as recsname
from
  cd.members mems
  left outer join cd.members recs on recs.memid = mems.recommendedby
order by
  memsname,
  memfname;

--Question 15:
select
  distinct recs.firstname as firstname,
  recs.surname as surname
from
  cd.members mems
  inner join cd.members recs on recs.memid = mems.recommendedby
order by
  surname,
  firstname;

--Question 16:
select
  distinct mems.firstname || ' ' || mems.surname as member,
  (
    select
      recs.firstname || ' ' || recs.surname as recommender
    from
      cd.members recs
    where
      recs.memid = mems.recommendedby
  )
from
  cd.members mems
order by
  member;

--Question 17:
select recommendedby, count(*)
	from cd.members
	where recommendedby is not null
	group by recommendedby
order by recommendedby;

--Question 18:
select
  facid,
  sum(slots) as "Total Slots"
from
  cd.bookings
group by
  facid
order by
  facid;

--Question 19:
select
    facid,
    sum(slots) as "Total Slots"
from
    cd.bookings
where
    starttime >= '2012-09-01'
    and starttime < '2012-10-01'
group by
    facid
order by
    sum(slots);

--Question 20:
select
  facid,
  extract(
    month
    from
      starttime
  ) as month,
  sum(slots) as "Total Slots"
from
  cd.bookings
where
  extract(
    year
    from
      starttime
  ) = 2012
group by
  facid,
  month
order by
  facid,
  month;

--Question 21:
select
    count(distinct memid)
from
    cd.bookings;

--Question 22:
select
    mems.surname,
    mems.firstname,
    mems.memid,
    min(bks.starttime) as starttime
from
    cd.bookings bks
        inner join cd.members mems on mems.memid = bks.memid
where
    starttime >= '2012-09-01'
group by
    mems.surname,
    mems.firstname,
    mems.memid
order by
    mems.memid;

--Question 23:
select
    count(*) over(),
    firstname,
    surname
from
    cd.members
order by
    joindate;

--Question 24:
select
    row_number() over(
    order by
      joindate
  ),
    firstname,
    surname
from
    cd.members
order by
    joindate;

--Question 25:
select
    facid,
    total
from
    (
        select
            facid,
            sum(slots) total,
            rank() over (
        order by
          sum(slots) desc
      ) rank
        from
            cd.bookings
        group by
            facid
    ) as ranked
where
    rank = 1;

--Question 26:
select
    surname || ', ' || firstname as name
from
    cd.members;

--Question 27:
select
    memid,
    telephone
from
    cd.members
where
    telephone ~ '[()]';

--Question 28:
select
    substr (mems.surname, 1, 1) as letter,
    count(*) as count
from
    cd.members mems
group by
    letter
order by
    letter;