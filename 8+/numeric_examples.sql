# 1.
/* The example shows the number who responded for: question 1, at 'Edinburgh Napier University',
studying '(8) Computer Science' */
SELECT A_STRONGLY_AGREE FROM nss
WHERE question = 'Q01'
   AND institution = 'Edinburgh Napier University'
   AND subject = '(8) Computer Science'


# 2.
# Show the institution and subject where the score is at least 100 for question 15.
SELECT institution, subject FROM nss
WHERE question = 'Q15'
	AND score >= 100


# 3.
# Show the institution and score where the score for '(8) Computer Science' is less than 50 for question 'Q15'.
SELECT institution, score FROM nss
WHERE question = 'Q15'
	AND subject = '(8) Computer Science'
	AND score < 50


# 4.
/* Show the subject and total number of students who responded to question 22 for each of the subjects 
'(8) Computer Science' and '(H) Creative Arts and Design'. */
SELECT subject, SUM(response) FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design')


# 5.
/* Show the subject and total number of students who A_STRONGLY_AGREE to question 22 for each of the subjects 
'(8) Computer Science' and '(H) Creative Arts and Design'. */
SELECT subject, SUM((response * A_STRONGLY_AGREE) / 100) FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design')


# 6.
/* Show the percentage of students who A_STRONGLY_AGREE to question 22 for the subject '(8) Computer Science' 
show the same figure for the subject '(H) Creative Arts and Design'. */
SELECT 
	subject, 
	ROUND(SUM(A_STRONGLY_AGREE * response) / SUM(response))
FROM nss
WHERE question = 'Q22'
GROUP BY subject
HAVING subject IN ('(8) Computer Science', '(H) Creative Arts and Design')


# 7.
# Show the average scores for question 'Q22' for each institution that include 'Manchester' in the name.
SELECT 
	institution, 
	ROUND(SUM(score * response) / SUM(response)) AS score 
FROM nss
WHERE question = 'Q22'
	AND institution LIKE '%Manchester%'
GROUP BY institution


# 8.
# Show the institution, the total sample size and the number of computing students for institutions in Manchester for 'Q01'.

SELECT total.institution, total.total_sample, comp_stud.total_comp FROM
	(
	SELECT x.institution, SUM(x.sample) AS total_sample FROM nss x
	WHERE question = 'Q01'
		AND x.institution LIKE '%Manchester%'
	GROUP BY x.institution
	) AS total
JOIN
	(
	SELECT y.institution, SUM(y.sample) AS total_comp
	FROM nss y
	WHERE question = 'Q01'
		AND (y.institution LIKE '%Manchester%')
		AND y.subject LIKE '%computer%'
	GROUP BY y.institution
	) AS comp_stud
ON total.institution = comp_stud.institution
