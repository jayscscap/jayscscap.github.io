use messaging;

insert into person (first_name, last_name)
	values ('Alexandria', 'Naldrett-Jays');

alter table person
	add username varchar(15) not null;

update person
	set username = 'ajays'
	where person_id = 7;

delete from person
	where first_name = "Diana" and last_name = "Taurasi";

alter table contact_list
	add favorite varchar(10) null;

update contact_list
	set favorite = 'Y'
	where contact_id = 1;

update contact_list
	set favorite = 'N'
	where contact_id != 1;

insert into contact_list (person_id, contact_id, favorite)
	values
	(1, 7, 'N'),
	(3, 7, 'Y'),
	(4, 7, 'N');

create table image (
	image_id int(8) not null auto_increment,
	image_name varchar(50) not null,
	image_location varchar(250) not null,
	primary key (image_id)
	) auto_increment = 1;

create table message_image (
	message_id int(8) not null,
	image_id int(8) not null,
	primary key (message_id, image_id));

insert into image (image_name, image_location)
	values
	('selfie number 9', 'Hotel de Rio'),
	('beach', 'Rio Resort'),
	('selfie number 13', 'Casa del Sol Bar'),
	('drinks', 'Casa del Sol Bar'),
	('medal', 'Hotel de Rio');

insert into message_image (message_id, image_id)
	values
	(1, 1),
	(3, 2),
	(4, 3),
	(4, 4),
	(2, 5);

select sender.first_name as sender_fn, sender.last_name as sender_ln,
	rec.first_name as rec_fn, rec.last_name as rec_ln,
	message.message_id, message.message, message.send_datetime
	from message
	join person as sender on sender.person_id = message.sender_id
	join person as rec on rec.person_id = message.receiver_id
	where message.sender_id = 1;

select count(message.message_id) as message_total, 
	person.person_id, person.first_name, person.last_name
	from message
		join person on message.sender_id = person.person_id
	where person.person_id > 0
	group by message.sender_id;

select message.message_id, message.message, message.send_datetime,
	image.image_name, image.image_location
	from message
		join message_image on message.message_id = message_image.message_id
		join image on message_image.image_id = image.image_id
	where image.image_id >= 1
	group by message.message_id;


/*update primary key to create a primary key that can be updated since person_id auto increments*/
alter table person
	drop primary key,
	add primary key(person_id, username);


/*add email column*/
alter table person
	add email varchar(40) not null;

/*add email to Kevin Durant*/
update person
	set email = 'kdurant@email.com'
	where person_id = 5;


/*insert row into person table, but if a duplicate email has been identified update the username*/
insert into person (first_name, last_name, username, email) values ('Kevin', 'Durant', 'kdurant', 'kdurant@email.com')
	on duplicate key update username = 'kdurant';

/*replace values in allyson felix's rows*/
replace	into person ('person_id', 'username', 'email') values (4, 'afelix', 'afelix@account.com')
