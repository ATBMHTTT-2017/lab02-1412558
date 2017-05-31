-- HASH KEY
create or replace function Hash_key(p_key IN VARCHAR2) return RAW DETERMINISTIC
IS
r_key RAW(128) := UTL_RAW.cast_to_raw(p_key);
r_HASH raw(1024);
BEGIN
	r_HASH := dbms_crypto.hash(src => r_key,typ => dbms_crypto.HASH_SH1);
	return r_HASH;
END Hash_key;


-- MÃ HÓA
create or replace function encrypt_chitieu_SOTIEN(p_data IN VARCHAR2,p_key IN VARCHAR2)
return RAW DETERMINISTIC
IS
r_key RAW(128) := UTL_RAW.cast_to_raw(p_key);
r_data raw(1024) := utl_raw.cast_to_raw(p_data);
r_encrypted raw(1024);
BEGIN
	r_encrypted := dbms_crypto.encrypt(src => r_data,typ => dbms_crypto.DES_CBC_PKCS5,key => r_key);
	return r_encrypted;
END encrypt_chitieu_SOTIEN;

--- GIẢI MÃ
create or replace function DECRYPT_CHITIEU_SOTIEN(p_data IN VARCHAR2,p_hash_key in VARCHAR2,p_key IN VARCHAR2)
return VARCHAR2 DETERMINISTIC
IS
r_key RAW(128) := UTL_RAW.cast_to_raw(p_key);
r_decrypted raw(1024);
r_HASH raw(1024);
BEGIN
	r_HASH := dbms_crypto.hash(src => r_key,typ => dbms_crypto.HASH_SH1);
	if (r_HASH = p_hash_key) then
	r_decrypted := dbms_crypto.decrypt(src => p_data,typ => dbms_crypto.DES_CBC_PKCS5,key => r_key);
	return utl_raw.cast_to_varchar2(r_decrypted);
	else
		return TO_CHAR(p_data);
	end if;
END DECRYPT_CHITIEU_SOTIEN;

-- Thêm cột hash_key vào bảng chi tiêu
alter table LAB02.CHITIEU add HASH_KEY  varchar2(512);
-- thêm cột số tiền được mã hóa
alter table LAB02.CHITIEU add ENCRYPT_SOTIEN  varchar2(512);

-- Update cột Hash_key trong bảng chi tiêu
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_001') where DUAN = 'DA001';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_002') where DUAN = 'DA002';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_003') where DUAN = 'DA003';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_004') where DUAN = 'DA004';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_005') where DUAN = 'DA005';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_006') where DUAN = 'DA006';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_007') where DUAN = 'DA007';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_008') where DUAN = 'DA008';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_009') where DUAN = 'DA009';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_010') where DUAN = 'DA010';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_011') where DUAN = 'DA011';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_012') where DUAN = 'DA012';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_013') where DUAN = 'DA013';
update LAB02.CHITIEU set HASH_KEY = Hash_key('password_ABC_014') where DUAN = 'DA014';

-- Update cột ENCRYPT_SOTIEN trong bảng chi tiêu
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_001') where DUAN = 'DA001';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_002') where DUAN = 'DA002';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_003') where DUAN = 'DA003';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_004') where DUAN = 'DA004';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_005') where DUAN = 'DA005';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_006') where DUAN = 'DA006';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_007') where DUAN = 'DA007';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_008') where DUAN = 'DA008';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_009') where DUAN = 'DA009';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_010') where DUAN = 'DA010';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_011') where DUAN = 'DA011';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_012') where DUAN = 'DA012';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_013') where DUAN = 'DA013';
update LAB02.CHITIEU set ENCRYPT_SOTIEN = ENCRYPT_CHITIEU_SOTIEN(SOTIEN,'password_ABC_014') where DUAN = 'DA014';

select * from chitieu;
-- Bây giờ select như sau, cần nhập key đúng thì mới hiện số tiền
select MACHITIEU, DECRYPT_CHITIEU_SOTIEN(ENCRYPT_SOTIEN, HASH_KEY, 'password_ABC_013') as SOTIEN,DUAN from LAB02.CHITIEU;
