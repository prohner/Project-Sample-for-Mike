/*
Jumps
	Side-by-side jumps (23)
	Throws (16)

Spins
	Side-by-side spins (40)
	Pair spins (8)

Spirals
	Step and Spiral Sequences (16)
	Death Spirals (16)

Lifts
	Lifts (32)
	Twist lifts (48)
*/
set nocount on
drop table #elements;
create table #elements (id integer identity(1, 1) primary key, discipline varchar(25), element_group varchar(25), description varchar(55), ijs_id varchar(15), base_score real, plus_1 real, plus_2 real, plus_3 real, minus_1 real, minus_2 real, minus_3 real);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Toeloop',	'1T',  1.0, 0.6, 0.3, 0.4, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Salchow',	'1S',  1.0, 0.6, 0.3, 0.4, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Loop',		'1Lo', 1.0, 0.6, 0.3, 0.5, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Flip',		'1F',  1.0, 0.6, 0.3, 0.5, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Lutz',		'1Lz', 1.0, 0.6, 0.3, 0.6, -0.1, -0.2, -0.3);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Axel', 			  	'1A',  1.5, 1.0, 0.5, 0.8, -0.2, -0.4, -0.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Double Toeloop',	'2T',  1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Double Salchow',	'2S',  1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Double Loop',		'2Lo', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Double Flip',		'2F',  1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Double Lutz',		'2Lz', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Double Axel', 		'2A',  3.0, 2.0, 1.0, 3.5, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Triple Toeloop',	'3T',  3.0, 2.0, 1.0, 4.0, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Triple Salchow',	'3S',  3.0, 2.0, 1.0, 4.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Triple Loop',		'3Lo', 3.0, 2.0, 1.0, 5.0, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Triple Flip',		'3F',  3.0, 2.0, 1.0, 5.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Triple Lutz',		'3Lz', 3.0, 2.0, 1.0, 6.0, -1.0, -2.0, -3.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Triple Axel', 		'3A',  3.0, 2.0, 1.0,  8.2, -1.4, -2.8, -4.2);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Quad Toeloop',		'4T',  3.0, 2.0, 1.0,  9.8, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Quad Salchow',		'4S',  3.0, 2.0, 1.0, 10.3, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Quad Loop',			'4Lo', 3.0, 2.0, 1.0, 10.8, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Quad Flip',			'4F',  3.0, 2.0, 1.0, 11.3, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Quad Lutz',			'4Lz', 3.0, 2.0, 1.0, 11.8, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side jumps', 'Quad Axel', 		'4A',  3.0, 2.0, 1.0, 13.3, -1.6, -3.2, -4.8);


insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Upright Spin Level 1', 'USp1', 1.5, 1.0, 0.5, 1.2, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Upright Spin Level 2', 'USp2', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Upright Spin Level 3', 'USp3', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Upright Spin Level 4', 'USp4', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Layback Spin Level 1', 'LSp1', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Layback Spin Level 2', 'LSp2', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Layback Spin Level 3', 'LSp3', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Layback Spin Level 4', 'LSp4', 1.5, 1.0, 0.5, 2.7, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Camel Spin Level 1', 'CSp1', 1.5, 1.0, 0.5, 1.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Camel Spin Level 2', 'CSp2', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Camel Spin Level 3', 'CSp3', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Camel Spin Level 4', 'CSp4', 1.5, 1.0, 0.5, 2.6, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Sit Spin Level 1', 'SSp1', 1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Sit Spin Level 2', 'SSp2', 1.5, 1.0, 0.5, 1.6, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Sit Spin Level 3', 'SSp3', 1.5, 1.0, 0.5, 2.1, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Sit Spin Level 4', 'SSp4', 1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Upright Spin Level 1', 'CUSp1', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Upright Spin Level 2', 'CUSp2', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Upright Spin Level 3', 'CUSp3', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Upright Spin Level 4', 'CUSp4', 1.5, 1.0, 0.5, 2.9, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Layback Spin Level 1', 'CLSp1', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Layback Spin Level 2', 'CLSp2', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Layback Spin Level 3', 'CLSp3', 1.5, 1.0, 0.5, 2.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Layback Spin Level 4', 'CLSp4', 1.5, 1.0, 0.5, 3.2, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Camel Spin Level 1', 'CCSp1', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Camel Spin Level 2', 'CCSp2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Camel Spin Level 3', 'CCSp3', 1.5, 1.0, 0.5, 2.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Camel Spin Level 4', 'CCSp4', 1.5, 1.0, 0.5, 3.2, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Sit Spin Level 1', 'CSSp1', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Sit Spin Level 2', 'CSSp2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Sit Spin Level 3', 'CSSp3', 1.5, 1.0, 0.5, 2.6, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Change Foot Sit Spin Level 4', 'CSSp4', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Spin Combo Chg Pos Not Foot Level 1', 'CoSp1', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Spin Combo Chg Pos Not Foot Level 2', 'CoSp2', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Spin Combo Chg Pos Not Foot Level 3', 'CoSp3', 1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Spin Combo Chg Pos Not Foot Level 4', 'CoSp4', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Spin Combo Chg Pos & Foot Level 1', 'CCoSp1', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Spin Combo Chg Pos & Foot Level 2', 'CCoSp2', 1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Spin Combo Chg Pos & Foot Level 3', 'CCoSp3', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'side-by-side spins', 'Spin Combo Chg Pos & Foot Level 4', 'CCoSp4', 1.5, 1.0, 0.5, 3.5, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Straight Line Step Seq Level 1', 'SlSt1', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Straight Line Step Seq Level 2', 'SlSt2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Straight Line Step Seq Level 3', 'SlSt3', 1.5, 1.0, 0.5, 3.3, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Straight Line Step Seq Level 4', 'SlSt4', 3.0, 2.0, 1.0, 3.9, -0.7, -1.4, -2.1);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Circular Step Seq Level 1', 'CiSt1', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Circular Step Seq Level 2', 'CiSt2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Circular Step Seq Level 3', 'CiSt3', 1.5, 1.0, 0.5, 3.3, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Circular Step Seq Level 4', 'CiSt4', 3.0, 2.0, 1.0, 3.9, -0.7, -1.4, -2.1);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Serpentine Step Seq Level 1', 'SeSt1', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Serpentine Step Seq Level 2', 'SeSt2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Serpentine Step Seq Level 3', 'SeSt3', 1.5, 1.0, 0.5, 3.3, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Serpentine Step Seq Level 4', 'SeSt4', 3.0, 2.0, 1.0, 3.9, -0.7, -1.4, -2.1);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Spiral Sequence (Circular, Serpentine) Level 1', 'SpSq1', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Spiral Sequence (Circular, Serpentine) Level 2', 'SpSq2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Spiral Sequence (Circular, Serpentine) Level 3', 'SpSq3', 1.5, 1.0, 0.5, 3.1, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'spiral/step', 'Spiral Sequence (Circular, Serpentine) Level 4', 'SpSq4', 3.0, 2.0, 1.0, 3.4, -0.7, -1.4, -2.1);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 1 Level 1', '1Li1', 1.0, 0.6, 0.3, 1.1, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 1 Level 2', '1Li2', 1.0, 0.6, 0.3, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 1 Level 3', '1Li3', 1.0, 0.6, 0.3, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 1 Level 4', '1Li4', 1.0, 0.6, 0.3, 1.7, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 2 Level 1', '2Li1', 1.0, 0.6, 0.3, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 2 Level 2', '2Li2', 1.0, 0.6, 0.3, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 2 Level 3', '2Li3', 1.0, 0.6, 0.3, 2.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 2 Level 4', '2Li4', 1.0, 0.6, 0.3, 3.0, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 3 Level 1', '3Li1', 1.5, 1.0, 0.5, 2.5, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 3 Level 2', '3Li2', 1.5, 1.0, 0.5, 3.0, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 3 Level 3', '3Li3', 1.5, 1.0, 0.5, 3.5, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 3 Level 4', '3Li4', 1.5, 1.0, 0.5, 4.0, -0.5, -1.0, -1.5);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 4 Level 1', '4Li1', 1.5, 1.0, 0.5, 2.5, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 4 Level 2', '4Li2', 1.5, 1.0, 0.5, 3.0, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 4 Level 3', '4Li3', 1.5, 1.0, 0.5, 3.5, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 4 Level 4', '4Li4', 1.5, 1.0, 0.5, 4.0, -0.5, -1.0, -1.5);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Toe Lasso Level 1', '5TLi1', 1.5, 1.0, 0.5, 4.5, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Toe Lasso Level 2', '5TLi2', 1.5, 1.0, 0.5, 5.0, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Toe Lasso Level 3', '5TLi3', 1.5, 1.0, 0.5, 5.5, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Toe Lasso Level 4', '5TLi4', 1.5, 1.0, 0.5, 6.0, -0.5, -1.0, -1.5);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Step in Lasso Level 1', '5SLi1', 1.5, 1.0, 0.5, 4.5, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Step in Lasso Level 2', '5SLi2', 1.5, 1.0, 0.5, 5.0, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Step in Lasso Level 3', '5SLi3', 1.5, 1.0, 0.5, 5.5, -0.5, -1.0, -1.5);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Step in Lasso Level 4', '5SLi4', 1.5, 1.0, 0.5, 6.0, -0.5, -1.0, -1.5);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Reverse Lasso Level 1', '5RLi1', 2.0, 1.4, 0.7, 5.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Reverse Lasso Level 2', '5RLi2', 2.0, 1.4, 0.7, 5.5, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Reverse Lasso Level 3', '5RLi3', 3.0, 2.0, 1.0, 6.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Reverse Lasso Level 4', '5RLi4', 3.0, 2.0, 1.0, 6.5, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Axel Lasso Level 1', '5ALi1', 2.0, 1.4, 0.7, 5.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Axel Lasso Level 2', '5ALi2', 2.0, 1.4, 0.7, 5.5, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Axel Lasso Level 3', '5ALi3', 3.0, 2.0, 1.0, 6.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'lifts', 'Group 5 Axel Lasso Level 4', '5ALi4', 3.0, 2.0, 1.0, 6.5, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Toeloop Level 1', '1TTw1', 1.5, 1.0, 0.5, 1.1, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Toeloop Level 2', '1TTw2', 1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Toeloop Level 3', '1TTw3', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Toeloop Level 4', '1TTw4', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Toeloop Level 1', '2TTw1', 1.5, 1.0, 0.5, 2.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Toeloop Level 2', '2TTw2', 1.5, 1.0, 0.5, 3.2, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Toeloop Level 3', '2TTw3', 1.5, 1.0, 0.5, 3.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Toeloop Level 4', '2TTw4', 1.5, 1.0, 0.5, 4.2, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Toeloop Level 1', '3TTw1', 2.0, 1.4, 0.7, 4.7, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Toeloop Level 2', '3TTw2', 2.0, 1.4, 0.7, 5.2, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Toeloop Level 3', '3TTw3', 2.0, 1.4, 0.7, 5.7, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Toeloop Level 4', '3TTw4', 2.0, 1.4, 0.7, 6.2, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Toeloop Level 1', '4TTw1', 2.0, 1.4, 0.7, 6.2, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Toeloop Level 2', '4TTw2', 2.0, 1.4, 0.7, 6.7, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Toeloop Level 3', '4TTw3', 2.0, 1.4, 0.7, 7.2, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Toeloop Level 4', '4TTw4', 2.0, 1.4, 0.7, 7.7, -1.0, -2.0, -3.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Lutz/Flip Level 1', '1LzTw1', 1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Lutz/Flip Level 2', '1LzTw2', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Lutz/Flip Level 3', '1LzTw3', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Lutz/Flip Level 4', '1LzTw4', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Lutz/Flip Level 1', '2LzTw1', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Lutz/Flip Level 2', '2LzTw2', 1.5, 1.0, 0.5, 3.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Lutz/Flip Level 3', '2LzTw3', 1.5, 1.0, 0.5, 4.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Lutz/Flip Level 4', '2LzTw4', 1.5, 1.0, 0.5, 4.5, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Lutz/Flip Level 1', '3LzTw1', 2.0, 1.4, 0.7, 5.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Lutz/Flip Level 2', '3LzTw2', 2.0, 1.4, 0.7, 5.5, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Lutz/Flip Level 3', '3LzTw3', 2.0, 1.4, 0.7, 6.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Lutz/Flip Level 4', '3LzTw4', 2.0, 1.4, 0.7, 6.5, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Lutz/Flip Level 1', '4LzTw1', 2.0, 1.4, 0.7, 6.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Lutz/Flip Level 2', '4LzTw2', 2.0, 1.4, 0.7, 7.0, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Lutz/Flip Level 3', '4LzTw3', 2.0, 1.4, 0.7, 7.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Lutz/Flip Level 4', '4LzTw4', 2.0, 1.4, 0.7, 8.0, -1.0, -2.0, -3.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Axel Level 1', '1ATw1', 1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Axel Level 2', '1ATw2', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Axel Level 3', '1ATw3', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Single Axel Level 4', '1ATw4', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Axel Level 1', '2ATw1', 1.5, 1.0, 0.5, 3.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Axel Level 2', '2ATw2', 1.5, 1.0, 0.5, 3.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Axel Level 3', '2ATw3', 1.5, 1.0, 0.5, 4.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Double Axel Level 4', '2ATw4', 1.5, 1.0, 0.5, 4.8, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Axel Level 1', '3ATw1',  2.0, 1.4, 0.7, 5.3, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Axel Level 2', '3ATw2',  2.0, 1.4, 0.7, 5.5, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Axel Level 3', '3ATw3',  2.0, 1.4, 0.7, 6.3, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Triple Axel Level 4', '3ATw4',  2.0, 1.4, 0.7, 6.8, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Axel Level 1', '4ATw1',  2.0, 1.4, 0.7, 5.3, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Axel Level 2', '4ATw2',  2.0, 1.4, 0.7, 5.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Axel Level 3', '4ATw3',  2.0, 1.4, 0.7, 6.3, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'twist lifts', 'Quad Axel Level 4', '4ATw4',  2.0, 1.4, 0.7, 6.8, -1.0, -2.0, -3.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Toeloop',				'1TTh',  1.0, 0.6, 0.3, 1.2, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Salchow',				'1STh',  1.0, 0.6, 0.3, 1.2, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Loop',					'1LoTh', 1.0, 0.6, 0.3, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Flip/Lutz',				'1FTh',  1.0, 0.6, 0.3, 1.5, -0.3, -0.6, -1.0);
           
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Axel', 			  		'1ATh',  1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Double Toeloop',		'2TTh',  1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Double Salchow',		'2STh',  1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Double Loop',			'2LoTh', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Double Flip/Lutz',	'2FTh',  1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
           
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Double Axel', 			'2ATh',  2.0, 1.4, 0.7, 4.0, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Triple Toeloop',		'3TTh',  2.0, 1.4, 0.7, 4.5, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Triple Salchow',		'3STh',  2.0, 1.4, 0.7, 4.5, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Triple Loop',			'3LoTh', 2.0, 1.4, 0.7, 5.0, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Triple Flip/Lutz',	'3FTh',  2.0, 1.4, 0.7, 5.5, -0.7, -1.4, -2.1);
           
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Triple Axel', 			'3ATh',  3.0, 2.0, 1.0,  7.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Quad Toeloop',			'4TTh',  3.0, 2.0, 1.0,  8.0, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Quad Salchow',			'4STh',  3.0, 2.0, 1.0,  8.0, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Quad Loop',				'4LoTh', 3.0, 2.0, 1.0,  8.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'throws', 'Quad Flip/Lutz',		'4FTh',  3.0, 2.0, 1.0,  9.0, -1.0, -2.0, -3.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Forward inside Level 1', 'FiDs1',  2.0, 1.4, 0.7, 2.8, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Forward inside Level 2', 'FiDs2',  2.0, 1.4, 0.7, 3.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Forward inside Level 3', 'FiDs3',  2.0, 1.4, 0.7, 3.2, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Forward inside Level 4', 'FiDs4',  2.0, 1.4, 0.7, 3.5, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Backward inside Level 1', 'BiDs1',  2.0, 1.4, 0.7, 2.8, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Backward inside Level 2', 'BiDs2',  2.0, 1.4, 0.7, 3.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Backward inside Level 3', 'BiDs3',  2.0, 1.4, 0.7, 3.2, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Backward inside Level 4', 'BiDs4',  2.0, 1.4, 0.7, 3.5, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Forward outside Level 1', 'FoDs1',  2.0, 1.4, 0.7, 3.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Forward outside Level 2', 'FoDs2',  2.0, 1.4, 0.7, 3.5, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Forward outside Level 3', 'FoDs3',  2.0, 1.4, 0.7, 4.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Forward outside Level 4', 'FoDs4',  2.0, 1.4, 0.7, 4.5, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Backward outside Level 1', 'BoDs1',  2.0, 1.4, 0.7, 3.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Backward outside Level 2', 'BoDs2',  2.0, 1.4, 0.7, 3.5, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Backward outside Level 3', 'BoDs3',  2.0, 1.4, 0.7, 4.0, -0.7, -1.4, -2.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'death spirals', 'Backward outside Level 4', 'BoDs4',  2.0, 1.4, 0.7, 4.5, -0.7, -1.4, -2.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'pair spins', 'Pair Spin Level 1', 'PSp1',  1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'pair spins', 'Pair Spin Level 2', 'PSp2',  1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'pair spins', 'Pair Spin Level 3', 'PSp3',  1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'pair spins', 'Pair Spin Level 4', 'PSp4',  1.5, 1.0, 0.5, 3.5, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'pair spins', 'Pair Combination Level 1', 'PCoSp1',  1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'pair spins', 'Pair Combination Level 2', 'PCoSp2',  1.5, 1.0, 0.5, 3.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'pair spins', 'Pair Combination Level 3', 'PCoSp3',  1.5, 1.0, 0.5, 4.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('pairs', 'pair spins', 'Pair Combination Level 4', 'PCoSp4',  1.5, 1.0, 0.5, 4.5, -0.3, -0.6, -1.0);

	select '[Elements addElement:@"' + ijs_id + '" discipline:DISCIPLINE_PAIRS'
	     + '  elementGroup:' + case when element_group = 'jumps'				then 'ELEMENT_GROUP_JUMPS' 
	                                when element_group = 'spins'				then 'ELEMENT_GROUP_SPINS' 
	                                when element_group = 'spiral/step'			then 'ELEMENT_GROUP_STEP_SPIRAL' 
	                                when element_group = 'death spirals'		then 'ELEMENT_GROUP_DEATH_SPIRALS'
	                                when element_group = 'lifts'				then 'ELEMENT_GROUP_LIFTS'
	                                when element_group = 'pair spins'			then 'ELEMENT_GROUP_PAIR_SPINS'
	                                when element_group = 'side-by-side jumps'	then 'ELEMENT_GROUP_SIDE_BY_SIDE_JUMPS'
	                                when element_group = 'side-by-side spins'	then 'ELEMENT_GROUP_SIDE_BY_SIDE_SPINS'
	                                when element_group = 'throws'				then 'ELEMENT_GROUP_THROWS'
	                                when element_group = 'twist lifts'			then 'ELEMENT_GROUP_TWIST_LIFTS'
	                           end + ' description:@"' + description 
	     + '" baseScore:' + convert(varchar, base_score) 
	     +  ' plus_1:' + convert(varchar, plus_1) + ' plus_2:' + convert(varchar, plus_2) + ' plus_3:' + convert(varchar, plus_3) 
	     + ' minus_1:' + convert(varchar, minus_1) + ' minus_2:' + convert(varchar, minus_2) + ' minus_3:' + convert(varchar, minus_3) 
	     + '];'
	  from #elements

set nocount off
