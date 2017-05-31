
---	Chi truong du an duoc phep xem, cap nhat thong tin chi tieu du an cua minh. - VPD

--- Tao function
create or replace function View_Update_ChiTieuCuaDA (object_schema in varchar2, object_name in varchar2)
return varchar2
as
	getUser varchar2(5);
	getMaDA varchar2(5);
	SL number;

begin
	getUser := sys_context('userenv', 'session_user');
	select COUNT(*) INTO SL from HCMUS.DUAN where TRUONGDA =getUser;

	if (SL != 0) then
		select MADA into getMaDA from HCMUS.DUAN where TRUONGDA = getUser;
		return 'DuAn = ' || getMaDA;
    else return ''; 
    end if;
end;


--Gan chinh sach vao bang CHITIEU
begin
  dbms_rls.add_policy
  (
      object_schema => 'HCMUS',
      object_name => 'CHITIEU',
      policy_name => 'View_Update_ChiTieuCuaDA_policy',
      policy_function => 'View_Update_ChiTieuCuaDA',
      statement_types => 'select, update',
      update_check => TRUE    
  );
end;
