
-- Example 1 - Refactor SQL

SELECT full_name 
	,  kpi1*kpi2 as ratio
from (
SELECT full_name
	,  product_name
	,  quantity
	,  price
	,  price/quantity kpi1
	,  1/quantity::float kpi2
FROM (
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS full_name,
    c.email,
    p.product_name,
    p.category,
    p.price,
    s.quantity,
    s.sale_amount,
    s.effective_date AS sale_effective_date,
    s.expiration_date AS sale_expiration_date
FROM
    staging_sales_fact s
JOIN customer_dim c ON s.customer_id = c.customer_id AND c.is_current = 'y'
JOIN product_dim p ON s.product_id = p.product_id AND p.is_current = 'y'
WHERE
    s.is_current = 'y'
)
)


'''

Eliminate Redundant Subquery: The outermost subquery that calculates ratio can be integrated into the inner subquery to simplify the query structure.
Direct Calculation of ratio: Calculate ratio (kpi1*kpi2) directly in the main subquery to avoid unnecessary nesting.
Alias for Subqueries: Use meaningful aliases for subqueries and tables to improve readability.
Column Selection: Since only full_name and the calculated ratio are required in the final output, ensure that only these fields are processed in the final SELECT statement.


'''


SELECT 
    c.first_name || ' ' || c.last_name AS full_name,
    (p.price / s.quantity) * (1 / s.quantity::float) AS ratio
FROM
    staging_sales_fact s
JOIN 
    customer_dim c ON s.customer_id = c.customer_id AND c.is_current = 'y'
JOIN 
    product_dim p ON s.product_id = p.product_id AND p.is_current = 'y'
WHERE
    s.is_current = 'y';


-- Example 2 SQL - Explain Complex SQL

SELECT wp4.postID
, wp4.creationDate
, wp4.numLinkedPosts
FROM (SELECT wp3.*
, dbo.getnumLinkedPosts(wp3.postID) AS numLinkedPosts
FROM (SELECT wp2.postID
, wp2.AcceptedAnswerId
, wp2.AnswerCount
, wp2.Body
, wp2.ClosedDate
, wp2.CommentCount
, wp2.CommunityOwnedDate
, wp2.CreationDate
, wp2.FavoriteCount
, wp2.LastActivityDate
, wp2.LastEditDate
, wp2.LastEditorDisplayName
, wp2.LastEditorUserId
, wp2.OwnerUserId
, wp2.ParentId
, wp2.PostTypeId
, wp2.Score
, wp2.Tags
, wp2.Title
, wp2.ViewCount
, wp2.AboutMe
, wp2.Age
, wp2.UserCreationDate
, wp2.DisplayName
, wp2.DownVotes
, wp2.EmailHash
, wp2.LastAccessDate
, wp2.[Location]
, wp2.Reputation
, wp2.UpVotes
, wp2.[Views]
, wp2.WebsiteUrl
, wp2.AccountId
, wp2.PostType
, wp2.voteType
, wp2.numVotes
, commentUnpivot.commentID
, commentUnpivot.commentCreationDate
, commentUnpivot.commentScore
, commentUnpivot.commentText
, commentUnpivot.commentUserID
FROM (SELECT wp1.postID
, wp1.AcceptedAnswerId
, wp1.AnswerCount
, wp1.Body
, wp1.ClosedDate
, wp1.CommentCount
, wp1.CommunityOwnedDate
, wp1.CreationDate
, wp1.FavoriteCount
, wp1.LastActivityDate
, wp1.LastEditDate
, wp1.LastEditorDisplayName
, wp1.LastEditorUserId
, wp1.OwnerUserId
, wp1.ParentId
, wp1.PostTypeId
, wp1.Score
, wp1.Tags
, wp1.Title
, wp1.ViewCount
, wp1.AboutMe
, wp1.Age
, wp1.UserCreationDate
, wp1.DisplayName
, wp1.DownVotes
, wp1.EmailHash
, wp1.LastAccessDate
, wp1.[Location]
, wp1.Reputation
, wp1.UpVotes
, wp1.[Views]
, wp1.WebsiteUrl
, wp1.AccountId
, wp1.CommentId1
, wp1.CommentCreationDate1
, wp1.CommentScore1
, wp1.CommentText1
, wp1.CommentUserId1
, wp1.CommentId2
, wp1.CommentCreationDate2
, wp1.CommentScore2
, wp1.CommentText2
, wp1.CommentUserId2
, wp1.CommentId3
, wp1.CommentCreationDate3
, wp1.CommentScore3
, wp1.CommentText3
, wp1.CommentUserId3
, wp1.CommentId4
, wp1.CommentCreationDate4
, wp1.CommentScore4
, wp1.CommentText4
, wp1.CommentUserId4
, wp1.CommentId5
, wp1.CommentCreationDate5
, wp1.CommentScore5
, wp1.CommentText5
, wp1.CommentUserId5
, wp1.PostType
, vty.[name] AS VoteType
, COUNT(wp1.voteUser) AS numVotes
FROM (SELECT wp.*
, pt.Type AS PostType
, vt.Userid AS voteUser
FROM (SELECT
p.Id AS postID
, p.AcceptedAnswerId
, p.AnswerCount
, p.Body
, p.ClosedDate
, p.CommentCount
, p.CommunityOwnedDate
, p.CreationDate
, p.FavoriteCount
, p.LastActivityDate
, p.LastEditDate
, p.LastEditorDisplayName
, p.LastEditorUserId
, p.OwnerUserId
, p.ParentId
, p.PostTypeId
, p.Score
, p.Tags
, p.Title
, p.ViewCount
, u.AboutMe
, u.Age
, u.CreationDate AS UserCreationDate
, u.DisplayName
, u.DownVotes
, u.EmailHash
, u.LastAccessDate
, u.Location
, u.Reputation
, u.UpVotes
, u.Views
, u.WebsiteUrl
, u.AccountId
, c.CommentId1
, c.CommentCreationDate1
, c.CommentScore1
, c.CommentText1
, c.CommentUserId1
, c.CommentId2
, c.CommentCreationDate2
, c.CommentScore2
, c.CommentText2
, c.CommentUserId2
, c.CommentCreationDate3
, c.CommentScore3
, c.CommentText3
, c.CommentUserId3
, c.CommentId4
, c.CommentCreationDate4
, c.CommentScore4
, c.CommentText4
, c.CommentUserId4
, c.CommentId5
, c.CommentCreationDate5
, c.CommentScore5
, c.CommentText5
, c.CommentUserId5
FROM dbo.Posts p
INNER JOIN dbo.Users u ON p.OwnerUserId = u.Id
OUTER APPLY (SELECT coms.PostId
, MAX(CASE WHEN theRowNum = 1 THEN coms.Id ELSE NULL END) AS
CommentId1
, MAX(CASE WHEN theRowNum = 1 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate1
, MAX(CASE WHEN theRowNum = 1 THEN coms.Score ELSE NULL END) AS
CommentScore1
, MAX(CASE WHEN theRowNum = 1 THEN coms.[Text] ELSE NULL END)
AS CommentText1
, MAX(CASE WHEN theRowNum = 1 THEN coms.UserId ELSE NULL END)
AS CommentUserID1
, MAX(CASE WHEN theRowNum = 2 THEN coms.Id ELSE NULL END) AS
CommentId2
, MAX(CASE WHEN theRowNum = 2 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate2
, MAX(CASE WHEN theRowNum = 2 THEN coms.Score ELSE NULL END) AS
CommentScore2
, MAX(CASE WHEN theRowNum = 2 THEN coms.[Text] ELSE NULL END)
AS CommentText2
, MAX(CASE WHEN theRowNum = 2 THEN coms.UserId ELSE NULL END)
AS CommentUserID2
, MAX(CASE WHEN theRowNum = 3 THEN coms.Id ELSE NULL END) AS
CommentId3
, MAX(CASE WHEN theRowNum = 3 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate3
, MAX(CASE WHEN theRowNum = 3 THEN coms.Score ELSE NULL END) AS
CommentScore3
, MAX(CASE WHEN theRowNum = 3 THEN coms.[Text] ELSE NULL END)
AS CommentText3
, MAX(CASE WHEN theRowNum = 3 THEN coms.UserId ELSE NULL END)
AS CommentUserID3
, MAX(CASE WHEN theRowNum = 4 THEN coms.Id ELSE NULL END) AS
CommentId4
, MAX(CASE WHEN theRowNum = 4 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate4
, MAX(CASE WHEN theRowNum = 4 THEN coms.Score ELSE NULL END) AS
CommentScore4
, MAX(CASE WHEN theRowNum = 4 THEN coms.[Text] ELSE NULL END)
AS CommentText4
, MAX(CASE WHEN theRowNum = 4 THEN coms.UserId ELSE NULL END)
AS CommentUserID4
, MAX(CASE WHEN theRowNum = 5 THEN coms.Id ELSE NULL END) AS
CommentId5
, MAX(CASE WHEN theRowNum = 5 THEN coms.CreationDate ELSE NULL
END) AS CommentCreationDate5
, MAX(CASE WHEN theRowNum = 5 THEN coms.Score ELSE NULL END) AS
CommentScore5
, MAX(CASE WHEN theRowNum = 5 THEN coms.[Text] ELSE NULL END)
AS CommentText5
, MAX(CASE WHEN theRowNum = 5 THEN coms.UserId ELSE NULL END)
AS CommentUserID5
FROM (SELECT Id
, CreationDate
, Score
, [Text]
, UserId
, PostId
, ROW_NUMBER() OVER (PARTITION BY PostId ORDER BY
CreationDate) AS theRowNum
FROM dbo.comments com
WHERE com.postID = p.Id) coms
WHERE coms.theRowNum <= 5
GROUP BY coms.PostId) c
) wp --WidePostsCh4
INNER JOIN dbo.PostTypes pt ON wp.PostTypeID = pt.Id
INNER JOIN dbo.Votes vt ON vt.PostId = wp.PostID) wp1
INNER JOIN dbo.Votes vt ON vt.PostId = wp1.PostID
INNER JOIN dbo.VoteTypes vty ON vt.VoteTypeId = vty.Id
WHERE wp1.voteUser = vt.UserId
GROUP BY wp1.postID
, wp1.AcceptedAnswerId
, wp1.AnswerCount
, wp1.Body
, wp1.ClosedDate
, wp1.CommentCount
, wp1.CommunityOwnedDate
, wp1.CreationDate
, wp1.FavoriteCount
, wp1.LastActivityDate
, wp1.LastEditDate
, wp1.LastEditorDisplayName
, wp1.LastEditorUserId
, wp1.OwnerUserId
, wp1.ParentId
, wp1.PostTypeId
, wp1.Score
, wp1.Tags
, wp1.Title
, wp1.ViewCount
, wp1.AboutMe
, wp1.Age
, wp1.UserCreationDate
, wp1.DisplayName
, wp1.DownVotes
, wp1.EmailHash
, wp1.LastAccessDate
, wp1.[Location]
, wp1.Reputation
, wp1.UpVotes
, wp1.[Views]
, wp1.WebsiteUrl
, wp1.AccountId
, wp1.CommentId1
, wp1.CommentCreationDate1
, wp1.CommentScore1
, wp1.CommentText1
, wp1.CommentUserId1
, wp1.CommentId2
, wp1.CommentCreationDate2
, wp1.CommentScore2
, wp1.CommentText2
, wp1.CommentUserId2
, wp1.CommentId3
, wp1.CommentCreationDate3
, wp1.CommentScore3
, wp1.CommentText3
, wp1.CommentUserId3
, wp1.CommentId4
, wp1.CommentCreationDate4
, wp1.CommentScore4
, wp1.CommentText4
, wp1.CommentUserId4
, wp1.CommentId5
, wp1.CommentCreationDate5
, wp1.CommentScore5
, wp1.CommentText5
, wp1.CommentUserId5
, wp1.PostType
, vt.VoteTypeID
, vty.[Name]
) wp2 --WidePostsPlusTwo
INNER JOIN (SELECT CommentID1 AS commentID
, CommentCreationDate1 AS commentCreationDate
, CommentScore1 AS commentScore
, CommentText1 AS commentText
, CommentUserID1 AS commentUserID
, PostID
FROM dbo.WidePostsPlusTwo
UNION ALL
SELECT CommentID2
, CommentCreationDate2
, CommentScore2
, CommentText2
, CommentUserID2
, PostID
FROM dbo.WidePostsPlusTwo
UNION ALL
SELECT CommentID3
, CommentCreationDate3
, CommentScore3
, CommentText3
, CommentUserID3
, PostID
FROM dbo.WidePostsPlusTwo
UNION ALL
SELECT CommentID4
, CommentCreationDate4
, CommentScore4
, CommentText4
, CommentUserID4
, PostID
FROM dbo.WidePostsPlusTwo
UNION ALL
SELECT CommentID5
, CommentCreationDate5
, CommentScore5
, CommentText5
, CommentUserID5
, PostID
FROM dbo.WidePostsPlusTwo) commentUnpivot
ON wp2.postID = commentUnpivot.postID
) wp3 --WidePostsPlusThree
WHERE wp3.commentID IS NOT NULL
) wp4 --WidePostsPlusFour
WHERE wp4.creationDate >='20120801'
AND wp4.creationDate < '20180901';


-- Example 2.1 SQL - Fix SQL

WITH CustPreferences AS (
SELECT c.CustomerID, c.CustFirstName, c.CustLastName,
MAX((CASE WHEN mp.PreferenceSeq = 1
THEN mp.StyleID
ELSE Null END)) AS FirstPreference,
MAX((CASE WHEN mp.PreferenceSeq = 2
THEN mp.StyleID
ELSE Null END)) AS SecondPreference,
MAX((CASE WHEN mp.PreferenceSeq = 3
THEN mp.StyleID
ELSE Null END)) AS ThirdPreference
FROM Musical_Preferences AS mp
INNER JOIN Customers AS c
ON mp.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustFirstName, c.CustLastName
);
EntStrengths AS (
SELECT e.EntertainerID, e.EntStageName,
MAX((CASE WHEN es.StyleStrength = 1
THEN es.StyleID
ELSE Null END)) AS FirstStrength,
MAX((CASE WHEN es.StyleStrength = 2
THEN es.StyleID
ELSE Null END)) AS SecondStrength,
MAX((CASE WHEN es.StyleStrength = 3
THEN es.StyleID
ELSE Null END)) AS ThirdStrength
FROM Entertainer_Styles AS es
INNER JOIN Entertainers AS e
ON es.EntertainerID = e.EntertainerID
GROUP BY e.EntertainerID, e.EntStageName
)S
ELECT CustomerID, CustFirstName, CustLastName,
EntertainerID, EntStageName
FROM CustPreferences
CROSS JOIN EntStrengths
WHERE (
FirstPreference = FirstStrength
AND SecondPreference = SecondStrength
) OR (
SecondPreference = FirstStrength
AND FirstPreference = SecondStrength
)
ORDER BY CustomerID;


-- Example 3 Postgres Calender SQL - Explain and Refactor

select max(case dw when 2 then dm end) as Mo,
max(case dw when 3 then dm end) as Tu,
max(case dw when 4 then dm end) as We,
max(case dw when 5 then dm end) as Th,
max(case dw when 6 then dm end) as Fr,
max(case dw when 7 then dm end) as Sa,
max(case dw when 1 then dm end) as Su
from (
select *
 from (
 select cast(date_trunc('month',current_date) as date)+x.id,
 to_char(
 cast(
 date_trunc('month',current_date)
 as date)+x.id,'iw') as wk,
 to_char(
 cast(
 date_trunc('month',current_date)
 as date)+x.id,'dd') as dm,
 cast(
 to_char(
 cast(
 date_trunc('month',current_date)
 as date)+x.id,'d') as integer) as dw,
 to_char(
 cast(
 date_trunc('month',current_date)
 as date)+x.id,'mm') as curr_mth,
 to_char(current_date,'mm') as mth
from generate_series (0,31) x(id)
) x
where mth = curr_mth
) y
group by wk
order by wk

-- Example 4 Recursive CTE  - Explain

with x (tree,mgr,depth)
as (
select cast(ename as varchar(100)),
mgr, 0
from emp
where ename = 'MILLER'
union all
select cast(x.tree+'-->'+e.ename as varchar(100)),
e.mgr, x.depth+1
 from emp e, x
 where x.mgr = e.empno
 )
 select tree leaf___branch___root
 from x
 where depth = 2


