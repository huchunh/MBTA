--CLEAN UP SCRIPT
set serveroutput on
declare
    v_table_exists varchar(1) := 'Y';
    v_sql varchar(2000);
begin
   dbms_output.put_line('Start schema cleanup');
   for i in (select 'TRANSIT' table_name from dual union all
             select 'WALLET' table_name from dual union all
             select 'TICKET' table_name from dual union all
             select 'STATION' table_name from dual union all
             select 'CARD' table_name from dual union all
             select 'RECHARGE_DEVICE' table_name from dual union all
             select 'RECHARGE' table_name from dual union all
             select 'PASS' table_name from dual union all
             select 'PASS_TYPE' table_name from dual union all
             select 'LINE' table_name from dual union all
             select 'TRANSACTION_DEVICE' table_name from dual union all
             select 'TRANSACTION' table_name from dual union all
             select 'LINE_STATION_CONNECTIONS' table_name from dual union all
             select 'OPERATIONS' table_name from dual

   )
   loop
   dbms_output.put_line('....Dropping table '||i.table_name);
   begin
       select 'Y' into v_table_exists
       from USER_TABLES
       where TABLE_NAME=i.table_name;

       v_sql := 'drop table '||i.table_name || ' cascade constraints';
       execute immediate v_sql;
       dbms_output.put_line('........Table '||i.table_name||' dropped successfully');
       
   exception
       when no_data_found then
           dbms_output.put_line('........Table already dropped');
   end;
   end loop;
   dbms_output.put_line('Schema cleanup successfully completed');
exception
   when others then
      dbms_output.put_line('Failed to execute code:'||sqlerrm);
end;
/

-- TABLE CREATION

CREATE TABLE TRANSIT (transit_id number GENERATED BY DEFAULT AS IDENTITY, name varchar(30), status varchar2(8), start_date date, price_per_ride float, PRIMARY KEY(transit_id), CONSTRAINT transit_status_options CHECK (status in ('Active','Inactive')));
CREATE TABLE WALLET(wallet_id number GENERATED BY DEFAULT AS IDENTITY, wallet_type varchar2(6), wallet_expiry date, start_date date, status varchar2(8), PRIMARY KEY(wallet_id), CONSTRAINT wallet_type_options CHECK (wallet_type in ('Card','Ticket')), CONSTRAINT wallet_status_options CHECK (status in ('Active','Inactive')));
CREATE TABLE TICKET(ticket_id number GENERATED BY DEFAULT AS IDENTITY, wallet_id number, rides number, transit_id number, PRIMARY KEY(ticket_id), FOREIGN KEY(wallet_id) REFERENCES WALLET(wallet_id), FOREIGN KEY(transit_id) REFERENCES TRANSIT(transit_id));
CREATE TABLE STATION (station_id number GENERATED BY DEFAULT AS IDENTITY, name varchar (30), construction_date date, PRIMARY KEY(station_id));
CREATE TABLE CARD(card_id number GENERATED BY DEFAULT AS IDENTITY, Balance number, wallet_id number, PRIMARY KEY(card_id), FOREIGN KEY(wallet_id) REFERENCES WALLET(wallet_id));
CREATE TABLE RECHARGE_DEVICE(recharge_device_id number GENERATED BY DEFAULT AS IDENTITY, station_id number, status varchar2(8), PRIMARY KEY(recharge_device_id), FOREIGN KEY (station_id) REFERENCES STATION(station_id),  CONSTRAINT recharge_device_status_options CHECK (status in ('Active','Inactive')));
CREATE TABLE RECHARGE(recharge_id number GENERATED BY DEFAULT AS IDENTITY, value_of_transaction number, wallet_id number, transaction_time timestamp, recharge_type VARCHAR2(6), recharge_device_id number, PRIMARY KEY(recharge_id), FOREIGN KEY(wallet_id) REFERENCES WALLET(wallet_id), FOREIGN KEY(recharge_device_id) REFERENCES RECHARGE_DEVICE(recharge_device_id), CONSTRAINT recharge_type_options CHECK (recharge_type in ('Top-up','Ride','Pass')));
CREATE TABLE PASS_TYPE(pass_type_id number GENERATED BY DEFAULT AS IDENTITY, price number, no_of_days number, name varchar(12), PRIMARY KEY(pass_type_id));
CREATE TABLE PASS(pass_id number GENERATED BY DEFAULT AS IDENTITY, card_id number, pass_expiry date, pass_type_id number, valid_from date, recharge_id number, PRIMARY KEY(pass_id), FOREIGN KEY(card_id) REFERENCES CARD(card_id), FOREIGN KEY(pass_type_id) REFERENCES PASS_TYPE(pass_type_id), FOREIGN KEY(recharge_id) REFERENCES RECHARGE(recharge_id));
CREATE TABLE LINE(line_id number GENERATED BY DEFAULT AS IDENTITY, transit_id number, name varchar (30), start_date timestamp, PRIMARY KEY(line_id), FOREIGN KEY(transit_id) REFERENCES TRANSIT(transit_id));
CREATE TABLE TRANSACTION_DEVICE(transaction_device_id number GENERATED BY DEFAULT AS IDENTITY, station_id number, line_id number, status varchar2(8), PRIMARY KEY(transaction_device_id), FOREIGN KEY (station_id) REFERENCES STATION(station_id), FOREIGN KEY (line_id) REFERENCES LINE(line_id),  CONSTRAINT transaction_device_status_options CHECK (status in ('Active','Inactive')));
CREATE TABLE TRANSACTION(transaction_id number GENERATED BY DEFAULT AS IDENTITY, transaction_type varchar(10), swipe_time timestamp, wallet_id number not null, value number, transaction_device_id number, PRIMARY KEY(transaction_id), FOREIGN KEY (wallet_id) REFERENCES wallet(wallet_id), FOREIGN KEY (transaction_device_id) REFERENCES TRANSACTION_DEVICE(transaction_device_id));
CREATE TABLE LINE_STATION_CONNECTIONS(connection_id number GENERATED BY DEFAULT AS IDENTITY,line_id number,station_id number,PRIMARY KEY(connection_id),FOREIGN KEY(line_id) REFERENCES LINE(line_id), FOREIGN KEY(station_id) REFERENCES STATION(station_id));
CREATE TABLE OPERATIONS(operation_id number GENERATED BY DEFAULT AS IDENTITY, start_time timestamp, end_time timestamp, reason varchar(50), 
log_timestamp timestamp, transit_id number, line_id number, station_id number,recharge_device_id number, transaction_device_id number, PRIMARY KEY(operation_id),FOREIGN KEY(transit_id) REFERENCES Transit(transit_id),FOREIGN KEY(line_id) REFERENCES Line(line_id),FOREIGN KEY (station_id) REFERENCES STATION(station_id), FOREIGN KEY (recharge_device_id) REFERENCES RECHARGE_DEVICE(Recharge_Device_id),FOREIGN KEY(transaction_device_id) REFERENCES Transaction_device(transaction_device_id));
/