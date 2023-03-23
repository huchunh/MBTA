--Sample file
create role admini;
grant all on Pass_Type to admini;
grant all on Pass to admini;
grant all on Wallet to admini;
grant all on Ticket to admini;
grant all on Card to admini;
grant all on Recharge to admini;
grant all on Transaction to admini;
grant all on Recharge_Device to admini;
grant all on Transaction_Device to admini;
grant all on Operations to admini;
grant all on Transit to admini;
grant all on Line to admini;
grant all on Station to admini;
grant all on Line_station_connections to admini;


create role developer;
grant all on Pass_Type to developer;
grant all on Pass to developer;
grant all on Wallet to developer;
grant all on Ticket to developer;
grant all on Card to developer;
grant all on Recharge to developer;
grant all on Transaction to developer;
grant all on Recharge_Device to developer;
grant all on Transaction_Device to developer;
grant all on Operations to developer;
grant all on Transit to developer;
grant all on Line to developer;
grant all on Station to developer;
grant all on Line_station_connections to developer;

create role QA;
grant all on Pass_Type to QA;
grant all on Pass to QA;
grant all on Wallet to QA;
grant all on Ticket to QA;
grant all on Card to QA;
grant all on Recharge to QA;
grant all on Transaction to QA;
grant all on Recharge_Device to QA;
grant all on Transaction_Device to QA;
grant all on Operations to QA;
grant all on Transit to QA;
grant all on Line to QA;
grant all on Station to QA;
grant all on Line_station_connections to QA;

create role transit_officer;
grant select on operation to transit_officer;
grant select on Line to transit_officer;
grant select on Transit to transit_officer;
grant select on Station to transit_officer;
grant select on Line_station_connections to transit_officer;

create role finance_officer;
grant select on Pass_Type to finance_officer;
grant select on Recharge to finance_officer;
grant select on Transaction to finance_officer;
grant select on Operations to finance_officer;
grant select on Transit to finance_officer;
grant select on Line to finance_officer;
grant select on Station to finance_officer;
grant select on Line_station_connections to finance_officer;

create role L1_officer;
grant select,update, insert, delete on Pass_Type to L1_officer;
grant select,update, insert, delete on Recharge_Device to L1_officer;
grant select,update, insert, delete on Transaction_Device to L1_officer;
grant select,update, insert, delete on Operations to L1_officer;
grant select,update, insert, delete on Transit to L1_officer;
grant select,update, insert, delete on Line to L1_officer;
grant select,update, insert, delete on Station to L1_officer;
grant select,update, insert, delete on Line_station_connections to L1_officer;

create role L2_officer;
grant all on Pass_Type to L2_officeri;
grant all on Pass to L2_officeri;
grant all on Wallet to L2_officeri;
grant all on Ticket to L2_officeri;
grant all on Card to L2_officeri;
grant all on Recharge to L2_officeri;
grant all on Transaction to L2_officeri;
grant all on Recharge_Device to L2_officeri;
grant all on Transaction_Device to L2_officeri;
grant all on Operations to L2_officeri;
grant all on Transit to L2_officeri;
grant all on Line to L2_officeri;
grant all on Station to L2_officeri;
grant all on Line_station_connections to L2_officeri;








create user H identified by abcd12341234A;
create user G identified by abcd12341234A;
create user Su identified by abcd12341234A;
CREATE USER SHR IDENTIFIED BY abcd12341234A;
grant connect, resource to H;
grant connect, resource to G;
grant connect, resource to Su;
grant connect, resource to SHR;
ALTER USER H QUOTA 1000 ON data;
ALTER USER G QUOTA 1000 ON data;
ALTER USER Su QUOTA 1000 ON data;
ALTER USER SHR QUOTA 1000 ON data;
grant developer to H;
grant developer to G;
grant developer to Su;
grant developer to SHR;




