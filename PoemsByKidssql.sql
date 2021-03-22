--Question 1
--What grades are stored in the database?
select [Name] from Grade

--Question 2
--What emotions may be associated with a poem?
Select [Name] from Emotion

--Question 3
--How many poems are in the database?
select Count(Id) from Poem

--Question 4
--Sort authors alphabetically by name. What are the names of the top 76 authors?
select Top 76 Name from Author
order by [Name]

--Question 5
--Starting with the above query, add the grade of each of the authors.
select Top 76 a.[Name], g.[Name] from Author a
	join Grade g
		on g.Id = a.GradeId
order by a.Name

--Question 6
--Starting with the above query, add the recorded gender of each of the authors.
select Top 76 a.Name, g.Name, ge.Name from Author a
	join Grade g
		on g.Id = a.GradeId
	join Gender ge
		on ge.Id = a.GenderId
order by a.Name

--Question 7
--What is the total number of words in all poems in the database?
Select sum(WordCount) from Poem

--Question 8
--Which poem has the fewest characters?
Select Title from Poem
where CharCount = (Select min(CharCount) from Poem)

--Question 9
--How many authors are in the third grade?
Select Count(*) from Author
where GradeId = 3

--Question 10
--How many authors are in the first, second or third grades?
Select Count(*) from Author
where GradeId = 1 or GradeId = 2 or GradeId = 3

--Question 11
--What is the total number of poems written by fourth graders?
Select Count(*) from Poem p
	join Author a
		on a.Id = p.AuthorId
where a.GradeId = 4

--Question 12
--How many poems are there per grade?
Select g.Name as GradeNumber, Count(*) as NumberOfPoems from Poem p
	join Author a
		on a.Id = p.AuthorId
	join Grade g
		on g.Id = a.GradeId
group by g.Name

--Question 13
--How many authors are in each grade?
Select g.Name as GradeNumber, Count(*) as NumberOfAuthors from Author a
	join Grade g
		on g.Id = a.GradeId
group by g.Name
order by g.Name

--Question 14
--What is the title of the poem that has the most words?
Select Title, WordCount from Poem
where WordCount = (select max(WordCount)from Poem)

--Question 15
--Which author(s) have the most poems?
Select Top 1 count(p.AuthorId) as NumberOfPoems, p.AuthorId, a.[Name] from Poem p
	join Author a
		on a.Id = p.AuthorId
group by a.[Name], p.AuthorId
order by NumberOfPoems desc

--Question 16
--How many poems have an emotion of sadness?
Select count(p.Id) from Poem p
	join PoemEmotion pe
		on pe.PoemId = p.Id
	join Emotion e
		on e.Id = pe.EmotionId
where e.Name = 'Sadness'

--Question 17
--How many poems are not associated with any emotion?
Select count(p.Id) from Poem p
	left join PoemEmotion pe
		on pe.PoemId = p.Id
where pe.EmotionId is Null

--Question 18
--Which emotion is associated with the least number of poems?
Select Top 1 count(p.Id) as NumberOfPoems, e.Name as Emotion from Poem p
	join PoemEmotion pe
		on pe.PoemId = p.Id
	join Emotion e
		on e.Id = pe.EmotionId
group by e.Name
order by NumberOfPoems asc

--Question 19
--Which grade has the largest number of poems with an emotion of joy?
Select Top 1 count(p.id) as NumberOfPoems, g.Name as Grade from Poem p
	join Author a
		on a.Id = p.AuthorId
	join Grade g
		on g.Id = a.GradeId
	join PoemEmotion pe
		on pe.PoemId = p.Id
	join Emotion e
		on e.Id = pe.EmotionId
where e.Name = 'Joy'
group by g.Name
order by NumberOfPoems desc

--Question 20
--Which gender has the least number of poems with an emotion of fear?
Select Top 1 count(p.id) as NumberOfPoems, ge.Name as Gender from Poem p
	join Author a
		on a.Id = p.AuthorId
	join Gender ge
		on ge.Id = a.GenderId
	join PoemEmotion pe
		on pe.PoemId = p.Id
	join Emotion e
		on e.Id = pe.EmotionId
where e.Name = 'Fear'
group by ge.Name
order by NumberOfPoems asc