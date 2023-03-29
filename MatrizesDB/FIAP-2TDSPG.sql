--Matrizes em Banco de dados, já é a tabela propriamente dita.
--Em banco o que fazemos em blocos de programação é a extração de um vetor dessa  matriz

SET SERVEROUTPUT ON
SET VERIFY OFF

/*
    CURSOR NOME_DO_CURSOR IS
    SELECT COLUNA_1, COLUNA_2,...,COLUNA_N
    FROM NOME_DA_TABELA;
    
    A criação do vetor está relacionado com o SELECT
    
    Comando do cursor:
       - OPEN: abre o cursor
       - FETCH: carga de dados
       - CLOSE: fecha o cursor
    
    ROWTYPE = HERANÇA
    
    DECLARE
        CURSOR C_ALUNO IS
        SELECT RA, NOME FROM ALUNO
        V_ALUNO C_ALUNO%ROWTYPE

    %FOUND: processe enquanto achar a próxima linha.
    %NOTFOUND: não existe a proxima linha? False -> processa
    %ROWCOUNT: quantas linhas o cursor processou
    %ISOPEN: teste se está aberto ou não => True está; False => não está
    
    Usar cursor, quando precisar várias linhas de uma vez!!
*/
drop table funcionario;

CREATE TABLE FUNCIONARIO(
CD_FUN      NUMBER(3)    PRIMARY KEY,
NM_FUN      VARCHAR(50)  NOT NULL,
SALARIO     NUMBER(10,2) NOT NULL,
DT_ADM      DATE         NOT NULL
);
--Aplicações em tempo real não funciona esse método:

    INSERT INTO FUNCIONARIO VALUES(1, 'Marcel', 10000, '17-APR-2000');
    INSERT INTO FUNCIONARIO VALUES(2, 'Claudia', 16000, '02-OCT-1998');
    INSERT INTO FUNCIONARIO VALUES(3, 'Joaquim', 5500, '10-JULY-2010');
    INSERT INTO FUNCIONARIO VALUES(4, 'Valéria', 7300, '08-JUNE-2015');
DECLARE
    CURSOR C_EXIBE IS SELECT NM_FUN, SALARIO FROM FUNCIONARIO;
    V_EXIBE C_EXIBE%ROWTYPE;
BEGIN
    OPEN C_EXIBE;
    LOOP
        FETCH C_EXIBE INTO V_EXIBE;
    EXIT WHEN C_EXIBE%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Nome: '|| V_EXIBE.NM_FUN || ' Salario: '||V_EXIBE.SALARIO);
    END LOOP;
    CLOSE C_EXIBE;
END;

--FOR:
/*
DECLARE
    CURSOR C_EXIBE IS SELECT NM_FUN,SALARIO FROM FUNCINARIO;
BEGIN
    FOR V_EXIBE IN C_EXIBE LOOP
        DBMS_OUTPUT.PUT_LINE('Nome: '|| V_EXIBE.NM_FUN ||'-Salário: '|| V_EXIBE.SALARIO);
    END LOOP;
END;*/


ALTER TABLE FUNCIONARIO ADD (TEMPO NUMBER(5));

DECLARE 
    CURSOR C_EXIBE IS SELECT * FROM FUNCIONARIO;
BEGIN
    FOR V_EXIBE IN C_EXIBE LOOP
    UPDATE FUNCIONARIO SET TEMPO = SYSDATE - V_EXIBE.DT_ADM
    WHERE CD_FUN = V_EXIBE.CD_FUN;
END LOOP;
END;

--SELECT * FROM FUNCIONARIO;

DECLARE
    CURSOR C_EXIBE IS SELECT * FROM FUNCIONARIO;

BEGIN
  FOR V_EXIBE IN C_EXIBE LOOP
    IF (V_EXIBE.TEMPO/30)>=150 THEN
        UPDATE FUNCIONARIO SET SALARIO = V_EXIBE.SALARIO + (V_EXIBE.SALARIO * 0.1)
        WHERE CD_FUN = V_EXIBE.CD_FUN;
    ELSE
        UPDATE FUNCIONARIO SET SALARIO = V_EXIBE.SALARIO + (V_EXIBE.SALARIO *0.05)
        WHERE CD_FUN = V_EXIBE.CD_FUN;
    END IF;
    END LOOP;
END;

select * from funcionario;