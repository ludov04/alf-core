## Why Alf?

The end of the relational era has been predicted many times since the middle of the '90s. So far, it has not been replaced by XML, nor by Object-Oriented databases, and I strongly predict that it won't be superseded by NoSQL technologies. 

Like a few others, I'm personally convinced that the so-called 'relational model' will stay. There are very good reasons for this, most of them have been explained in depth elsewhere. At the heart of our certainty lies the fact that the relational **is** a theory: a **sound**, **mathematical**, **powerful**, and **simple** theory. Most of the 'alternatives' are not.

Unfortunately, the relational theory is as unknown (or at least ill-known) as it is powerful. Therefore, continuous effort is required to help people understand what relational is about and what we would sorely miss if it had to be thrown away.

For this, we need to spend efforts along two lines: papers and tools. Alf mostly belongs to the second category. It is a relational tool, more precisely a pragmatic implementation of a flavor of **relational algebra**. You can use it both in Ruby and in Shell, using .csv files, DBMS tables, log files, or whatever you want as input data sources.

Yet, Alf is not about SQL. It is not even about databases, in fact. The relational theory covers a lot of co-related yet orthogonal concepts. One of them is the relational algebra. The latter is often seen as an _old-fashioned way of writing database queries_. I would be tempted to retort that elementary algebra must be an _old technique to solve problems in the ancient city of Babylon_. Is it?

### Further reading

* [Relational basics](/overview/relational-basics.html)
* [Where does Alf come from?](/overview/where-does-alf-come-from.html)