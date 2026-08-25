DELIMITER //

CREATE TRIGGER antes_insertar_boleto
BEFORE INSERT ON boletos
FOR EACH ROW
BEGIN
    DECLARE precio_funcion DECIMAL(10,2);

    SELECT precio
    INTO precio_funcion
    FROM funciones
    WHERE id_funcion = NEW.id_funcion;

    IF precio_funcion IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La función no existe';
    END IF;

    SET NEW.precio_pagado = precio_funcion;
END //

DELIMITER ;
