CREATE OR REPLACE TRIGGER pass_recharge
    AFTER INSERT ON RECHARGE
    FOR EACH ROW
    WHEN (new.recharge_type = 'Pass')
DECLARE
    v_Recharge_Value number;
    v_RECHARGE_ID number;
    v_CARD_ID number;
    v_Number_of_days number;
    v_PASS_TYPE number;
BEGIN
    v_Recharge_Value = new.value_of_transaction;
    v_RECHARGE_ID = new.recharge_id;
    v_CARD_ID = select distinct card_id from CARD where wallet_id = new.wallet_id;
    v_PASS_TYPE = select pass_id from PASS_TYPE where price = v_Recharge_Value;
    v_Number_of_days = select no_of_days from PASS_TYPE where price = v_Recharge_Value;
    
    INSERT INTO Pass(card_id,pass_expiry,pass_type_id, recharge_id, valid_from) values (v_CARD_ID,SYSDATE+v_Number_of_days,v_PASS_TYPE,v_RECHARGE_ID,SYSDATE);
    exception
        when others then
            dbms_output.put_line('INVALID TRANSACTION. REVERTING TRANSACTION');
            delete from RECHARGE where recharge_id = v_RECHARGE_ID;
END;
