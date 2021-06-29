CREATE DATABASE IF NOT EXISTS flight_sys;

USE flight_sys;

CREATE TABLE IF NOT EXISTS person(
	id CHAR(10),
	idno char(18),
	fullname CHAR(20) NOT NULL,
	telephone CHAR(11) NOT NULL,
	constraint pk_person primary key(id)
);

CREATE TABLE IF NOT EXISTS location(
	id char(10),
	location_name CHAR(20) NOT NULL,
	constraint pk_location primary key(id)
);

CREATE TABLE IF NOT EXISTS airline_info(
	id char(10),
	flight_id char(10) NOT NULL,
	capacity INT NOT NULL,
	s_time DATETIME NOT NULL,
	e_time DATETIME NOT NULL,
	s_loc_id char(10) NOT NULL,
	e_loc_id char(10) NOT NULL,
	price INT NOT NULL,
	constraint pk_airline_info primary key(id),
	constraint fk_airline_info_sid FOREIGN KEY (s_loc_id) references location(id),
	constraint fk_airline_info_eid FOREIGN KEY (e_loc_id) references location(id)
);

CREATE TABLE IF NOT EXISTS SEAT(
	id CHAR(10) ,
	a_id char(10) NOT NULL,
	p_id char(10) NOT NULL,
	seat_no char(3) NOT NULL,
	constraint pk_seat primary key(id),
	constraint fk_seat_pid FOREIGN KEY (p_id) references person(id),
	constraint fk_seat_aid FOREIGN KEY (a_id) references airline_info(id)
);

CREATE TABLE IF NOT EXISTS ticket_order(
	id char(10) primary key,
	seat_id char(10),
	payer_id char(10),
	status char(10),
	constraint fk_order_sid foreign key (seat_id) references seat(id),
	constraint fk_order_pid foreign key (payer_id) references person(id)
);


delimiter $
create trigger TS_T
after delete  on ticket_order for each row
    begin
        delete  from seat where id=old.seat_id;
    end;
$
delimiter ;