--공연정보
CREATE TABLE show_data (
    mt20id VARCHAR2(30) PRIMARY KEY,
    prfnm VARCHAR2(300),
    prfpdfrom DATE,
    prfpdto DATE,
    fcltynm VARCHAR2(300),
    poster VARCHAR2(300),
    area VARCHAR2(90),
    genrenm VARCHAR2(30),
    openrun CHAR(1),
    prfstate VARCHAR2(30)
);