# 1.
# One MSP was kicked out of the Labour party and has no party. Find him.
SELECT name FROM msp
WHERE party IS NULL


# 2.
# Obtain a list of all parties and leaders.
SELECT name, leader FROM party


# 3.
# Give the party and the leader for the parties which have leaders.
SELECT name, leader FROM party
WHERE leader IS NOT NULL


# 4.
# Obtain a list of all parties which have at least one MSP.
SELECT DISTINCT party.name FROM party
	JOIN msp ON code = party
WHERE msp.name IS NOT NULL


# 5.
/* Obtain a list of all MSPs by name, give the name of the MSP and the name of the party 
where available. Be sure that Canavan MSP, Dennis is in the list. Use ORDER BY msp.name to 
ort your output by MSP. */
SELECT msp.name, party.name FROM msp
	LEFT JOIN party ON party = code


# 6.
# Obtain a list of parties which have MSPs, include the number of MSPs.
SELECT party.name, COUNT(msp.name) FROM party
	JOIN msp ON code = party
WHERE msp.name IS NOT NULL
GROUP BY party.name


# 7.
# A list of parties with the number of MSPs; include parties with no MSPs.
SELECT party.name, COUNT(msp.name) FROM party
	LEFT JOIN msp ON code = party
GROUP BY party.name