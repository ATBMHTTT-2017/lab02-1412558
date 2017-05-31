CREATE OR REPLACE PACKAGE ENC_DEC 
AS
  FUNCTION ENCRYPT_SALARY(p_in IN varchar2,p_key IN VARCHAR2) RETURN RAW DETERMINISTIC;
  FUNCTION DECRYPT_SALARY(p_in IN RAW,p_key IN VARCHAR2) RETURN varchar2 DETERMINISTIC;
END ENC_DEC;


--2. CAI DAT 2 FUNCTION TREN
CREATE OR REPLACE PACKAGE BODY ENC_DEC  IS 
  encryption_type PLS_INTEGER :=
							 DBMS_CRYPTO.ENCRYPT_DES
							+DBMS_CRYPTO.CHAIN_CBC
							+DBMS_CRYPTO.PAD_PKCS5;
  FUNCTION ENCRYPT_SALARY(p_in IN varchar2,p_key IN VARCHAR2) RETURN RAW DETERMINISTIC
  IS
  	encrypted_raw raw(2000);
  BEGIN
       encrypted_raw := dbms_crypto.encrypt(
          src => utl_raw.cast_to_raw(p_in),
          typ => encryption_type,
          key => utl_raw.cast_to_raw(p_key)
      );
      return encrypted_raw;
  END ENCRYPT_SALARY;
  
  FUNCTION DECRYPT_SALARY(p_in IN RAW,p_key IN VARCHAR2) RETURN varchar2 DETERMINISTIC
  IS
    decrypted_raw raw(2000);
  BEGIN

       decrypted_raw := dbms_crypto.decrypt(
          src => p_in,
          typ => encryption_type,
          key => utl_raw.cast_to_raw(p_key)
      );
      
      return utl_raw.cast_to_varchar2(decrypted_raw);
  END DECRYPT_SALARY;
END ENC_DEC ;

--3: update table Nhanvien
UPDATE LAB02.NHANVIEN SET LAB02.NHANVIEN.HASHLUONG=ENC_DEC.ENCRYPT_SALARY(HASHLUONG,MANV||MANV);
UPDATE LAB02.NHANVIEN SET LAB02.NHANVIEN.HASHLUONG=ENC_DEC.DECRYPT_SALARY(HASHLUONG,MANV||MANV);
select * from LAB02.NHANVIEN;
