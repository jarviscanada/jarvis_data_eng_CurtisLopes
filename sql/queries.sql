--Question 1: Insert some data into a table
INSERT INTO cd.facilities
    (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
    VALUES (9, 'Spa', 20, 30, 100000, 800);

--Question 2: Insert calculated data into a table
INSERT INTO cd.facilities (
    facid, name, membercost, guestcost,
    initialoutlay, monthlymaintenance
)
SELECT
    (
        SELECT
            MAX(facid)
        FROM
            cd.facilities
    )+ 1,
    'Spa',
    20,
    30,
    100000,
    800;


--Question 3: Update some existing data
UPDATE cd.facilities
    SET initialoutlay = 10000
    WHERE facid = 1;

--Question 4: Update a row based on the contents of another row
UPDATE cd.facilities facs
SET
    membercost = (
        SELECT membercost * 1.1
        FROM cd.facilities
        WHERE facid = 0
    ),
    guestcost = (
        SELECT guestcost * 1.1
        FROM cd.facilities
        WHERE facid = 0
    )
WHERE
    facs.facid = 1;

--Question 5: Delete all bookings
DELETE FROM cd.bookings;

--Question 6: Delete a member from the cd.members table
DELETE FROM
    cd.members
WHERE
    memid = 37;

--Question 7: Control which rows are retrieved - part 2
SELECT
    facid,
    name,
    membercost,
    monthlymaintenance
FROM
    cd.facilities
WHERE
    membercost > 0
  AND (
    membercost < monthlymaintenance / 50.0
  );

--Question 8: Basic string searches
SELECT
    *
FROM
    cd.facilities
WHERE
    name LIKE '%Tennis%';

--Question 9: Matching against multiple possible values
SELECT
    *
FROM
    cd.facilities
WHERE
    facid in (1, 5);

--Question 10: Working with dates
SELECT
    memid,
    surname,
    firstname,
    joindate
FROM
    cd.members
WHERE
    joindate >= '2012-09-01';

--Question 11: Combining results from multiple queries
SELECT
    surname
FROM
    cd.members
UNION
SELECT
    name
FROM
    cd.facilities;

--Question 12: Retrieve the start times of members' bookings
SELECT
    bks.starttime
FROM
    cd.bookings bks
    INNER JOIN cd.members mems ON mems.memid = bks.memid
WHERE
    mems.firstname = 'David'
    AND mems.surname = 'Farrell';

--Question 13: Work out the start times of bookings for tennis courts
SELECT
    bks.starttime AS start,
    facs.name AS name
FROM
    cd.facilities facs
    INNER JOIN cd.bookings bks ON facs.facid = bks.facid
WHERE
    facs.name in (
        'Tennis Court 2', 'Tennis Court 1'
    )
    AND bks.starttime >= '2012-09-21'
    AND bks.starttime < '2012-09-22'
ORDER BY
    bks.starttime;

--Question 14: Produce a list of all members, along with their recommender
SELECT
    mems.firstname AS memfname,
    mems.surname AS memsname,
    recs.firstname AS recfname,
    recs.surname AS recsname
FROM
    cd.members mems
    LEFT OUTER JOIN cd.members recs ON recs.memid = mems.recommendedby
ORDER BY
    memsname,
    memfname;

--Question 15: Produce a list of all members who have recommended another member
SELECT
    DISTINCT recs.firstname AS firstname,
    recs.surname AS surname
FROM
    cd.members mems
    INNER JOIN cd.members recs ON recs.memid = mems.recommendedby
ORDER BY
    surname,
    firstname;

--Question 16: Produce a list of all members, along with their recommender, using no joins.
SELECT
    DISTINCT mems.firstname || ' ' || mems.surname AS member,
    (
        SELECT
            recs.firstname || ' ' || recs.surname AS recommender
        FROM
            cd.members recs
        WHERE
            recs.memid = mems.recommendedby
    )
FROM
    cd.members mems
ORDER BY
    member;

--Question 17: Count the number of recommendations each member makes.
SELECT recommendedby, COUNT(*)
	FROM cd.members
	WHERE recommendedby IS NOT NULL
	GROUP BY recommendedby
ORDER BY recommendedby;

--Question 18: List the total slots booked per facility
SELECT
    facid,
    SUM(slots) AS "Total Slots"
FROM
    cd.bookings
GROUP BY
    facid
ORDER BY
    facid;

--Question 19: List the total slots booked per facility in a given month
SELECT
    facid,
    SUM(slots) AS "Total Slots"
FROM
    cd.bookings
WHERE
    starttime >= '2012-09-01'
    AND starttime < '2012-10-01'
GROUP BY
    facid
ORDER BY
    SUM(slots);

--Question 20: List the total slots booked per facility per month
SELECT
    facid,
    EXTRACT(
        MONTH
        FROM
            starttime
    ) AS MONTH,
    SUM(slots) AS "Total Slots"
FROM
  cd.bookings
WHERE
    EXTRACT(
        YEAR
        FROM
        starttime
    ) = 2012
GROUP BY
    facid,
    MONTH
ORDER BY
    facid,
    MONTH;

--Question 21: Find the count of members who have made at least one booking
SELECT
    COUNT(DISTINCT memid)
FROM
    cd.bookings;

--Question 22: List each member's first booking after September 1st 2012
SELECT
    mems.surname,
    mems.firstname,
    mems.memid,
    MIN(bks.starttime) AS starttime
FROM
    cd.bookings bks
        INNER JOIN cd.members mems ON mems.memid = bks.memid
WHERE
    starttime >= '2012-09-01'
GROUP BY
    mems.surname,
    mems.firstname,
    mems.memid
ORDER BY
    mems.memid;

--Question 23: Produce a list of member names, with each row containing the total member count
SELECT
    COUNT(*) over(),
    firstname,
    surname
FROM
    cd.members
ORDER BY
    joindate;

--Question 24: Produce a numbered list of members
SELECT
    ROW_NUMBER() over(
    ORDER BY
      joindate
  ),
    firstname,
    surname
FROM
    cd.members
ORDER BY
    joindate;

--Question 25: Output the facility id that has the highest number of slots booked, again
SELECT
    facid,
    total
FROM
    (
        SELECT
            facid,
            SUM(slots) total,
            RANK() over (
        ORDER BY
          sum(slots) desc
      ) rank
        FROM
            cd.bookings
        GROUP BY
            facid
    ) AS ranked
WHERE
    rank = 1;

--Question 26: Format the names of members
SELECT
    surname || ', ' || firstname AS name
FROM
    cd.members;

--Question 27: Find telephone numbers with parentheses
SELECT
    memid,
    telephone
FROM
    cd.members
WHERE
    telephone ~ '[()]';

--Question 28: Count the number of members whose surname starts with each letter of the alphabet
SELECT
    SUBSTRING(mems.surname, 1, 1) AS letter,
    COUNT(*) AS COUNT
FROM
    cd.members mems
GROUP BY
    letter
ORDER BY
    letter;