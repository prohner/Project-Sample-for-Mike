set nocount on
drop table #elements;
create table #elements (id integer identity(1, 1) primary key, discipline varchar(25), element_group varchar(25), description varchar(55), ijs_id varchar(15), base_score real, plus_1 real, plus_2 real, plus_3 real, minus_1 real, minus_2 real, minus_3 real);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Toeloop', '1T', 1.0, 0.6, 0.3, 0.4, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Salchow', '1S', 1.0, 0.6, 0.3, 0.4, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Loop', '1Lo', 1.0, 0.6, 0.3, 0.5, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Flip', '1F', 1.0, 0.6, 0.3, 0.5, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Lutz', '1Lz', 1.0, 0.6, 0.3, 0.6, -0.1, -0.2, -0.3);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Axel', '1A', 1.5, 1.0, 0.5, 0.8, -0.2, -0.4, -0.5);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Double Toeloop', '2T', 1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Double Salchow', '2S', 1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Double Loop', '2Lo', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Double Flip', '2F', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Double Lutz', '2Lz', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Double Axel', '2A', 3.0, 2.0, 1.0, 3.5, -0.7, -1.4, -2.1);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Triple Toeloop', '3T', 3.0, 2.0, 1.0, 4.0, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Triple Salchow', '3S', 3.0, 2.0, 1.0, 4.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Triple Loop', '3Lo', 3.0, 2.0, 1.0, 5.0, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Triple Flip', '3F', 3.0, 2.0, 1.0, 5.5, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Triple Lutz', '3Lz', 3.0, 2.0, 1.0, 6.0, -1.0, -2.0, -3.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Triple Axel', '3A', 3.0, 2.0, 1.0, 8.2, -1.4, -2.8, -4.2);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Quad Toeloop', '4T', 3.0, 2.0, 1.0, 9.8, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Quad Salchow', '4S', 3.0, 2.0, 1.0, 10.3, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Quad Loop', '4Lo', 3.0, 2.0, 1.0, 10.8, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Quad Flip', '4F', 3.0, 2.0, 1.0, 11.3, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Quad Lutz', '4Lz', 3.0, 2.0, 1.0, 11.8, -1.6, -3.2, -4.8);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'jumps', 'Quad Axel', '4A', 3.0, 2.0, 1.0, 13.3, -1.6, -3.2, -4.8);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Upright Spin Level 1', 'USp1', 1.5, 1.0, 0.5, 1.2, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Upright Spin Level 2', 'USp2', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Upright Spin Level 3', 'USp3', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Upright Spin Level 4', 'USp4', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Layback Spin Level 1', 'LSp1', 1.5, 1.0, 0.5, 1.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Layback Spin Level 2', 'LSp2', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Layback Spin Level 3', 'LSp3', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Layback Spin Level 4', 'LSp4', 1.5, 1.0, 0.5, 2.7, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Camel Spin Level 1', 'CSp1', 1.5, 1.0, 0.5, 1.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Camel Spin Level 2', 'CSp2', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Camel Spin Level 3', 'CSp3', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Camel Spin Level 4', 'CSp4', 1.5, 1.0, 0.5, 2.6, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Sit Spin Level 1', 'SSp1', 1.5, 1.0, 0.5, 1.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Sit Spin Level 2', 'SSp2', 1.5, 1.0, 0.5, 1.6, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Sit Spin Level 3', 'SSp3', 1.5, 1.0, 0.5, 2.1, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Sit Spin Level 4', 'SSp4', 1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);
                       
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Upright Spin Level 1', 'FUSp1', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Upright Spin Level 2', 'FUSp2', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Upright Spin Level 3', 'FUSp3', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Upright Spin Level 4', 'FUSp4', 1.5, 1.0, 0.5, 2.9, -0.3, -0.6, -1.0);


insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Layback Spin Level 1', 'FLSp1', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Layback Spin Level 2', 'FLSp2', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Layback Spin Level 3', 'FLSp3', 1.5, 1.0, 0.5, 2.9, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Layback Spin Level 4', 'FLSp4', 1.5, 1.0, 0.5, 3.2, -0.3, -0.6, -1.0); 

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Camel Spin Level 1', 'FCSp1', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Camel Spin Level 2', 'FCSp2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Camel Spin Level 3', 'FCSp3', 1.5, 1.0, 0.5, 2.8, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Camel Spin Level 4', 'FCSp4', 1.5, 1.0, 0.5, 3.2, -0.3, -0.6, -1.0); 

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Sit Spin Level 1', 'FSSp1', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Sit Spin Level 2', 'FSSp2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Sit Spin Level 3', 'FSSp3', 1.5, 1.0, 0.5, 2.6, -0.3, -0.6, -1.0); 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Flying Sit Spin Level 4', 'FSSp4', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0); 

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Upright Spin Level 1', 'CUSp1', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Upright Spin Level 2', 'CUSp2', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Upright Spin Level 3', 'CUSp3', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Upright Spin Level 4', 'CUSp4', 1.5, 1.0, 0.5, 2.9, -0.3, -0.6, -1.0);
 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Layback Spin Level 1', 'CLSp1', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Layback Spin Level 2', 'CLSp2', 1.5, 1.0, 0.5, 2.4, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Layback Spin Level 3', 'CLSp3', 1.5, 1.0, 0.5, 2.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Layback Spin Level 4', 'CLSp4', 1.5, 1.0, 0.5, 3.2, -0.3, -0.6, -1.0);
 
 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Camel Spin Level 1', 'CCSp1', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Camel Spin Level 2', 'CCSp2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Camel Spin Level 3', 'CCSp3', 1.5, 1.0, 0.5, 2.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Camel Spin Level 4', 'CCSp4', 1.5, 1.0, 0.5, 3.2, -0.3, -0.6, -1.0);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Sit Spin Level 1', 'CSSp1', 1.5, 1.0, 0.5, 1.9, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Sit Spin Level 2', 'CSSp2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Sit Spin Level 3', 'CSSp3', 1.5, 1.0, 0.5, 2.6, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Change Foot Sit Spin Level 4', 'CSSp4', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Spin w/ Pos. Chg. Level 1', 'CoSp1', 1.5, 1.0, 0.5, 1.7, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Spin w/ Pos. Chg. Level 2', 'CoSp2', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Spin w/ Pos. Chg. Level 3', 'CoSp3', 1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Spin w/ Pos. Chg. Level 4', 'CoSp4', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
 
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Spin w/ Foot & Pos. Chg. Level 1', 'CCoSp1', 1.5, 1.0, 0.5, 2.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Spin w/ Foot & Pos. Chg. Level 2', 'CCoSp2', 1.5, 1.0, 0.5, 2.5, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Spin w/ Foot & Pos. Chg. Level 3', 'CCoSp3', 1.5, 1.0, 0.5, 3.0, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spins', 'Spin w/ Foot & Pos. Chg. Level 4', 'CCoSp4', 1.5, 1.0, 0.5, 3.5, -0.3, -0.6, -1.0);


insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Straight Line Step Sequence Level 1', 'SlSt1', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Straight Line Step Sequence Level 2', 'SlSt2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Straight Line Step Sequence Level 3', 'SlSt3', 1.5, 1.0, 0.5, 3.3, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Straight Line Step Sequence Level 4', 'SlSt4', 3.0, 2.0, 1.0, 3.9, -0.7, -1.4, -2.1);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Circular Step Sequence Level 1', 'CiSt1', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Circular Step Sequence Level 2', 'CiSt2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Circular Step Sequence Level 3', 'CiSt3', 1.5, 1.0, 0.5, 3.3, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Circular Step Sequence Level 4', 'CiSt4', 3.0, 2.0, 1.0, 3.9, -0.7, -1.4, -2.1);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Serpentine Step Sequence Level 1', 'SeSt1', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Serpentine Step Sequence Level 2', 'SeSt2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Serpentine Step Sequence Level 3', 'SeSt3', 1.5, 1.0, 0.5, 3.3, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Serpentine Step Sequence Level 4', 'SeSt4', 3.0, 2.0, 1.0, 3.9, -0.7, -1.4, -2.1);

insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Spiral Sequence (Circular, Serpentine) Level 1', 'SpSq1', 1.5, 1.0, 0.5, 1.8, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Spiral Sequence (Circular, Serpentine) Level 2', 'SpSq2', 1.5, 1.0, 0.5, 2.3, -0.3, -0.6, -1.0);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Spiral Sequence (Circular, Serpentine) Level 3', 'SpSq3', 1.5, 1.0, 0.5, 3.1, -0.7, -1.4, -2.1);
insert into #elements (discipline,  element_group, description, ijs_id, plus_3, plus_2, plus_1, base_score, minus_1, minus_2, minus_3) values ('singles', 'spiral/step', 'Spiral Sequence (Circular, Serpentine) Level 4', 'SpSq4', 3.0, 2.0, 1.0, 3.4, -0.7, -1.4, -2.1);

--select * from #elements

select '[Elements addElement:@"' + ijs_id + '" discipline:@"' + discipline + '" elementGroup:@"' + element_group + '" description:@"' + description 
     + '" baseScore:' + convert(varchar, base_score) 
     +  ' plus_1:' + convert(varchar, plus_1) + ' plus_2:' + convert(varchar, plus_2) + ' plus_3:' + convert(varchar, plus_3) 
     + ' minus_1:' + convert(varchar, minus_1) + ' minus_2:' + convert(varchar, minus_2) + ' minus_3:' + convert(varchar, minus_3) 
     + '];'
  from #elements
set nocount off